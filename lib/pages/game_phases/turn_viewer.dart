import 'package:flutter/material.dart';

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
            Text("$player1Name : $scorePlayer1 - $scorePlayer2 : $player2Name"),
            Text("$currentPlayer's turn", style: TextStyle(fontSize: 30)),
            ElevatedButton(onPressed: nextStep, child: Text("Next")),
          ],
        ),
      );
  }
}