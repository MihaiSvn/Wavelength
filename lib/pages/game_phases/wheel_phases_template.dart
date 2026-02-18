import 'package:flutter/material.dart';
import 'package:wavelength/controllers/cover_controller.dart';
import 'package:wavelength/util/current_player_title.dart';
import 'package:wavelength/util/scoreboard.dart';
import 'package:wavelength/util/wheel.dart';

class WheelPhasesTemplate extends StatefulWidget {
  final String player1Name, player2Name, currentPlayer;
  final int scorePlayer1, scorePlayer2;
  final VoidCallback nextStep;
  final String phase;
  const WheelPhasesTemplate({
    super.key,
    required this.player1Name,
    required this.player2Name,
    required this.currentPlayer,
    required this.scorePlayer1,
    required this.scorePlayer2,
    required this.nextStep,
    required this.phase,
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
  late String phase;
  
  @override
  void initState() {
    super.initState();
    phase = widget.phase;
    coverController = CoverController();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 40,
      children: [
        Scoreboard(
          player1Name: widget.player1Name,
          player2Name: widget.player2Name,
          scorePlayer1: widget.scorePlayer1,
          scorePlayer2: widget.scorePlayer2,
        ),
        CurrentPlayerTitle(currentPlayer: widget.currentPlayer),

        Wheel(
          phase: phase,
          onChanged: onNextButtonChanged,
          controller: coverController,
        ),
        Visibility(
          visible: !isNextButtonVisible && widget.phase == 'player_guessing',
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                coverController.toggleCover();
                isNextButtonVisible = true;
                phase = 'reveal_result';
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
