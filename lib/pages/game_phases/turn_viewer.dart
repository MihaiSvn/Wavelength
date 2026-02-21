import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/util/current_player_title.dart';
import 'package:wavelength/util/scoreboard.dart';

class TurnViewer extends StatelessWidget {
  final GameSettings settings;
  final GameState gameState;
  final VoidCallback nextStep;
  const TurnViewer({super.key, required this.gameState, required this.settings, required this.nextStep});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Scoreboard(player1Name: settings.player1Name, player2Name: settings.player2Name, scorePlayer1: gameState.scorePlayer1, scorePlayer2: gameState.scorePlayer2),
            CurrentPlayerTitle(currentPlayer: settings.currentPlayerToName(gameState.currentPlayer)),
            ElevatedButton(onPressed: nextStep, child: Text("Next")),
          ],
        ),
      );
  }
}