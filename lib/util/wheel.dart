import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wavelength/controllers/cover_controller.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_phases.dart';
import 'package:wavelength/models/wheel_behaviour.dart';

class Wheel extends StatefulWidget {
  final TurnPhases phase;
  final VoidCallback onChanged;
  final CoverController controller;
  final GameState gameState;
  final bool? debug;
  const Wheel({
    super.key,
    required this.phase,
    required this.onChanged,
    required this.controller,
    required this.gameState,
    this.debug = false,
  });

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> with SingleTickerProviderStateMixin {
  late TurnPhases phase;
  late double wheelTurn;
  double needleTurn = 0.0;
  bool isCoverVisible = true;
  bool continueButton = false;
  late WheelBehavior behavior;

  late AnimationController inertiaController;
  late Animation<double> inertiaAnimation;

  void spinWheel(double dx) {
    setState(() {
      wheelTurn += dx;
    });
  }

  void updateNeedle(Offset localPosition, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    //formam sistem de coordonate relativ la axul rotii, normal localPosition ar veni unde pe tot ecranul
    double dx = localPosition.dx - centerX;
    double dy = localPosition.dy - centerY;

    //atan iti da unde pe cerc trigonometric
    double radians =
        atan2(dy, dx) +
        (pi /
            2); // +pi/2 fiindca in geom 0 radiani e ora 3, dar sageata la noi sta in sus default (adica la 12)
    double turns = radians / (2 * pi);

    //fara astea doua daca iti misti degetul mai mult de jumate acul va sari
    if (turns > 0.5) turns -= 1.0;
    if (turns < -0.5) turns += 1.0;

    double clampedTurns = turns.clamp(
      -0.25,
      0.25,
    ); //limitez valori turn ai sa nu merg sub frame

    setState(() {
      needleTurn = clampedTurns;
      widget.gameState.updateNeedleTurn(needleTurn);
    });
  }

  void handleFling(DragEndDetails details) {
    double velocity = details.primaryVelocity ?? 0;

    if (velocity.abs() < 100) return; //daca e prea mic nu fac nimic

    double distance =
        velocity / 1000; //calculez dist pe care trebuie sa o parcurg

    inertiaAnimation =
        Tween<double>(
            begin: wheelTurn, //incep de la pozitia curenta
            end: wheelTurn + (distance / 5), //pana la asta
          ).animate(
            CurvedAnimation(
              //aplic fizica
              parent: inertiaController,
              curve: Curves.decelerate,
            ),
          )
          ..addListener(() {
            //actualizez variabila
            setState(() {
              wheelTurn = inertiaAnimation.value;
            });
          });

    inertiaController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    if (widget.debug == true) isCoverVisible = false;
    phase = widget.phase;
    wheelTurn = widget.gameState.wheelTurn;
    behavior = gamePhases[phase]!;
    inertiaController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void didUpdateWidget(covariant Wheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.phase != oldWidget.phase) {
      setState(() {
        behavior = gamePhases[widget.phase]!;
      });
    }
  }

  Widget _buildWheelImage() {
    final wheelImage = Image.asset('assets/images/wheel.png');

    if (widget.debug != true) {
      return AnimatedRotation(
        turns: wheelTurn,
        duration: const Duration(milliseconds: 50),
        child: wheelImage,
      );
    }

    return ListenableBuilder(
      listenable: widget.gameState,
      builder: (context, child) {
        return AnimatedRotation(
          turns: widget.gameState.wheelTurn,
          duration: const Duration(milliseconds: 50),
          child: wheelImage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. WHEEL
            _buildWheelImage(),

            // 2. LOGIC FOR WHEEL AND COVER
            ListenableBuilder(
              listenable: widget.controller,
              builder: (context, child) {
                return GestureDetector(
                  onHorizontalDragDown: (_) => inertiaController.stop(),
                  onHorizontalDragUpdate: (details) {
                    if (behavior.isCoverRevealable && details.delta.dx < -1.5) {
                      //any movement to the left will reveal cover
                      setState(() {
                        behavior = gamePhases[TurnPhases.showTurn]!;
                        widget.controller.toggleCover();
                        widget.gameState.updateTurn(wheelTurn);
                        isCoverVisible = false;
                        widget.onChanged();
                      });
                    } else if (behavior.isWheelSpinnable &&
                        details.delta.dx > 1) {
                      setState(() {
                        wheelTurn += details.delta.dx / 500;
                      });
                    }
                  },

                  //inertia
                  onHorizontalDragEnd: (details) {
                    if (behavior.isWheelSpinnable) handleFling(details);
                  },
                  child: AnimatedRotation(
                    turns: widget.controller.turns,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    child: widget.debug == false
                        ? Image.asset('assets/images/cover.png')
                        : Container(color: Colors.transparent),
                  ),
                );
              },
            ),

            // 3. FRAME
            IgnorePointer(child: Image.asset('assets/images/frame.png')),

            // 4. NEEDLE
            IgnorePointer(
              ignoring: !behavior.isNeedleDraggable,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (widget.debug == true) {
                    widget.gameState.updateScore();
                  }
                  updateNeedle(details.localPosition, context.size!);
                },
                child: AnimatedRotation(
                  turns: needleTurn,
                  duration: const Duration(milliseconds: 50),
                  child: Visibility(
                    visible: behavior.isNeedleVisible,
                    child: Image.asset('assets/images/needle.png'),
                  ),
                ),
              ),
            ),

            // 5. KNOB
            IgnorePointer(
              child: Visibility(
                visible: isCoverVisible,
                child: Image.asset('assets/images/cover_knob.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
