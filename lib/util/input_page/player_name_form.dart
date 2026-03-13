import 'package:flutter/material.dart';

class PlayerNameForm extends StatelessWidget {
  final int playerIndex;
  final TextEditingController controller;
  final int maxLength;
  const PlayerNameForm({
    super.key,
    required this.playerIndex,
    required this.controller,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text("Player $playerIndex..."),
        labelStyle: TextStyle(color: Colors.white70),
      ),
    );
  }
}
