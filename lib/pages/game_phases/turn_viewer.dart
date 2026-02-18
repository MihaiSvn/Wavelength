import 'package:flutter/material.dart';
import 'package:wavelength/util/current_player_title.dart';
import 'package:wavelength/util/scoreboard.dart';

class TurnViewer extends StatelessWidget {
  final String player1Name,player2Name,currentPlayer;
  final int scorePlayer1,scorePlayer2;
  final VoidCallback nextStep;
  const TurnViewer({super.key, required this.player1Name, required this.player2Name, required this.currentPlayer, required this.scorePlayer1, required this.scorePlayer2, required this.nextStep});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Scoreboard(player1Name: player1Name, player2Name: player2Name, scorePlayer1: scorePlayer1, scorePlayer2: scorePlayer2),
            CurrentPlayerTitle(currentPlayer: currentPlayer),
            ElevatedButton(onPressed: nextStep, child: Text("Next")),
          ],
        ),
      );
  }
}