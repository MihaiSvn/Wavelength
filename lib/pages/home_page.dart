import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/services/prompts_service.dart';
import 'package:wavelength/util/home_page/home_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  void handleChangeToPlayers(BuildContext context, String mode){
    Navigator.pushNamed(context, '/players_page',arguments: mode);
  }
  void handleChangeToDebug(BuildContext context, GameState gameState){
    Navigator.pushNamed(context, "/debug_wheel",arguments: gameState);
  }
  final PromptsService _promptsService = PromptsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(115, 27, 27, 27),
      body: Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "WAVELENGTH",
              style: TextStyle(
                fontSize: 40,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            HomeButton(buttonText: "CLASSIC MODE", onPressed: () => handleChangeToPlayers(context, "Classic")),
            HomeButton(buttonText: "ORIGINAL MODE", onPressed: () => handleChangeToPlayers(context, "Custom")),
            HomeButton(buttonText: "DEBUG WHEEL", onPressed: () => handleChangeToDebug(context, GameState())),
            HomeButton(buttonText: "CALL API", onPressed: () => _promptsService.fetchPrompts()),
          ],
        ),
      ),
    );
  }
}
