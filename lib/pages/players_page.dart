import 'package:flutter/material.dart';
import 'package:wavelength/util/input_page/game_form.dart';

class PlayersPage extends StatelessWidget {
  final String gameMode;
  const PlayersPage({super.key, required this.gameMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gameMode),
      centerTitle: true,),
      body: GameForm(gameMode: gameMode,),
    );
  }
}