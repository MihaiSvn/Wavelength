import 'package:flutter/material.dart';

class PlayerNameForm extends StatelessWidget {
  final int playerIndex;
  final TextEditingController controller;
  final int maxLength;
  const PlayerNameForm({super.key, required this.playerIndex, required this.controller, required this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: "Player $playerIndex...",
      ),
    );
  }
}