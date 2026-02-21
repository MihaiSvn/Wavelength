import 'package:flutter/material.dart';

class CurrentPlayerTitle extends StatelessWidget {
  final String currentPlayer;
  const CurrentPlayerTitle({super.key, required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    return Text("$currentPlayer's turn", style: TextStyle(fontSize: 30));
  }
}
