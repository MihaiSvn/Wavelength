import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_settings.dart';

class FinalScreen extends StatelessWidget {
  final GameSettings settings;
  final GameState gameState;
  final VoidCallback nextStep;

  const FinalScreen({
    super.key,
    required this.nextStep,
    required this.gameState,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    final String winnerName = gameState.scorePlayer1 > gameState.scorePlayer2
        ? settings.player1Name
        : settings.player2Name;

    final String loserName = gameState.scorePlayer1 > gameState.scorePlayer2
        ? settings.player2Name
        : settings.player1Name;
    int playerWon=1;
    if(winnerName==settings.player2Name)
      playerWon=2;
    return Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/winner-loser.png', 
                  width: 350,
                ),
            
                Positioned(
                  top: 20, 
                  left: 50,
                  child: Column(
                    children: [
                      Text(
                        winnerName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "WINNER!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        playerWon==1 ? gameState.scorePlayer1.toString() : gameState.scorePlayer2.toString(),
                      )
                    ],
                  ),
                ),
            
                Positioned(
                  bottom: 00, 
                  right: 40,
                  child: Column(
                    children: [
                      Text(
                        loserName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "SECOND PLACE",
                        style: TextStyle(fontSize: 14, color: Colors.redAccent),
                      ),
                      Text(
                        playerWon==1 ? gameState.scorePlayer2.toString() : gameState.scorePlayer1.toString(),
                        )
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: nextStep, child: Text("PLAY AGAIN")),
          ],
        ),
      );
  }
}
