import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:wavelength/controllers/cover_controller.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_phases.dart';
import 'package:wavelength/models/game_settings.dart';
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
  late ConfettiController _confettiController;
  late TurnPhases phase;

  @override
  void initState() {
    super.initState();
    phase = widget.gameState.currentPhase;
    coverController = CoverController();
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 400),
    );
    widget.gameState.confettiTrigger.addListener(_handleBullseye);
  }

  void _handleBullseye() {
    _confettiController.play();
  }

  @override
  void dispose() {
    widget.gameState.confettiTrigger.removeListener(_handleBullseye);
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Scoreboard(
              player1Name: widget.settings.player1Name,
              player2Name: widget.settings.player2Name,
              scorePlayer1: widget.gameState.scorePlayer1,
              scorePlayer2: widget.gameState.scorePlayer2,
              gameState: widget.gameState,
            ),
            if (isNextButtonVisible &&
                widget.gameState.currentPhase == TurnPhases.guesserGuess)
              Text(
                "${widget.gameState.currentPlayer == 1 ? widget.settings.player2Name : widget.settings.player1Name} scored ${widget.gameState.points} points",
              ),
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
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.yellow,
            Colors.pink,
            Colors.orange,
          ],
          numberOfParticles: 20,
          gravity: 0.1,
        ),
      ],
    );
  }
}
