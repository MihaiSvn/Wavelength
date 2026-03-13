import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/util/next_button.dart';

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
    bool player1Won = gameState.scorePlayer1 >= gameState.scorePlayer2;
    final String winnerName = player1Won ? settings.player1Name : settings.player2Name;
    final int winnerScore = player1Won ? gameState.scorePlayer1 : gameState.scorePlayer2;
    
    final String loserName = player1Won ? settings.player2Name : settings.player1Name;
    final int loserScore = player1Won ? gameState.scorePlayer2 : gameState.scorePlayer1;
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "GAME OVER",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
    
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end, 
              children: [
                _buildPodiumStep(
                  playerName: loserName,
                  score: loserScore,
                  rank: "2",
                  stepHeight: 150,
                  stepColor: const Color(0xFFC0C0C0), 
                  textColor: Colors.redAccent,
                ),
                
                const SizedBox(width: 15), 
                
                _buildPodiumStep(
                  playerName: winnerName,
                  score: winnerScore,
                  rank: "1",
                  stepHeight: 220,
                  stepColor: const Color(0xFFFFD700),
                  textColor: Colors.cyanAccent,
                  isWinner: true,
                ),
              ],
            ),
    
            NextButton(onPressed: nextStep, label: "PLAY AGAIN",),
          ],
        ),
      ),
    );
  }
}

Widget _buildPodiumStep({
    required String playerName,
    required int score,
    required String rank,
    required double stepHeight,
    required Color stepColor,
    required Color textColor,
    bool isWinner = false,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            playerName.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isWinner ? 22 : 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "$score PTS",
            style: TextStyle(
              fontSize: isWinner ? 18 : 14,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 15),
      
          Container(
            width: 130,
            height: stepHeight,
            decoration: BoxDecoration(
              color: stepColor.withOpacity(0.15),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border.all(color: stepColor.withOpacity(0.5), width: 2),
              boxShadow: isWinner ? [
                BoxShadow(
                  color: stepColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ] : null,
            ),
            child: Center(
              child: Text(
                rank,
                style: TextStyle(
                  fontSize: isWinner ? 60 : 40,
                  fontWeight: FontWeight.w900,
                  color: stepColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }