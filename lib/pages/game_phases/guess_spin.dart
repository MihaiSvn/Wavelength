import 'package:flutter/material.dart';
import 'package:wavelength/pages/game_phases/wheel_phases_template.dart';

class GuessSpin extends StatelessWidget {
  final String player1Name, player2Name, currentPlayer;
  final int scorePlayer1, scorePlayer2;
  final VoidCallback nextStep;
  const GuessSpin({
    super.key,
    required this.player1Name,
    required this.player2Name,
    required this.currentPlayer,
    required this.scorePlayer1,
    required this.scorePlayer2,
    required this.nextStep,
  });

  @override
  Widget build(BuildContext context) {
    return WheelPhasesTemplate(
      player1Name: player1Name,
      player2Name: player2Name,
      currentPlayer: currentPlayer,
      scorePlayer1: scorePlayer1,
      scorePlayer2: scorePlayer2,
      nextStep: nextStep,
      phase: 'player_guessing',
    );
  }
}
