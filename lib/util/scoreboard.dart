import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  final String player1Name, player2Name;
  final int scorePlayer1, scorePlayer2;
  const Scoreboard({
    super.key,
    required this.player1Name,
    required this.player2Name,
    required this.scorePlayer1,
    required this.scorePlayer2,
  });

  @override
  Widget build(BuildContext context) {
    return Text("$player1Name : $scorePlayer1 - $scorePlayer2 : $player2Name");
  }
}
