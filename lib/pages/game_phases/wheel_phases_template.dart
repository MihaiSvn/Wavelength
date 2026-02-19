import 'package:flutter/material.dart';
import 'package:wavelength/controllers/cover_controller.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_phases.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/util/current_player_title.dart';
import 'package:wavelength/util/scoreboard.dart';
import 'package:wavelength/util/wheel.dart';

class WheelPhasesTemplate extends StatefulWidget {
  final GameSettings settings;
  final GameState gameState;
  final VoidCallback nextStep;
  const WheelPhasesTemplate({
    super.key,
    required this.settings,
    required this.gameState,
    required this.nextStep,
  });

  @override
  State<WheelPhasesTemplate> createState() => _WheelPhasesTemplateState();
}

class _WheelPhasesTemplateState extends State<WheelPhasesTemplate> {
  bool isNextButtonVisible = false;
  void onNextButtonChanged() {
    setState(() {
      isNextButtonVisible = true;
    });
  }

  void onRevealCover() {
    setState(() {
      isNextButtonVisible = true;
    });
  }

  late final CoverController coverController;
  late TurnPhases phase;
  
  @override
  void initState() {
    super.initState();
    phase = widget.gameState.currentPhase;
    coverController = CoverController();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Scoreboard(
          player1Name: widget.settings.player1Name,
          player2Name: widget.settings.player2Name,
          scorePlayer1: widget.gameState.scorePlayer1,
          scorePlayer2: widget.gameState.scorePlayer2,
        ),
        CurrentPlayerTitle(currentPlayer: widget.settings.currentPlayerToName(widget.gameState.currentPlayer)),
        Text(widget.gameState.points.toString()),
        Wheel(
          phase: phase,
          onChanged: onNextButtonChanged,
          controller: coverController,
          gameState: widget.gameState,
        ),
        Visibility(
          visible: !isNextButtonVisible && phase == TurnPhases.guesserGuess,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                coverController.toggleCover();
                widget.gameState.updateScore();
                isNextButtonVisible = true;
                phase = TurnPhases.showTurn;
              });
            },
            child: const Text("Reveal cover"),
          ),
        ),
        Visibility(
          visible: isNextButtonVisible,
          child: ElevatedButton(
            onPressed: widget.nextStep,
            child: Text("Next"),
          ),
        ),
      ],
    );
  }
}
