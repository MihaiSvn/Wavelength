import 'package:flutter/material.dart';

class PlayerNameForm extends StatelessWidget {
  final int playerIndex;
  final TextEditingController controller;
  const PlayerNameForm({super.key, required this.playerIndex, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Player $playerIndex...",
      ),
    );
  }
}