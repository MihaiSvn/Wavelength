import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';

class Scoreboard extends StatelessWidget {
  final String player1Name, player2Name;
  final int scorePlayer1, scorePlayer2;
  final GameState gameState;
  const Scoreboard({
    super.key,
    required this.player1Name,
    required this.player2Name,
    required this.scorePlayer1,
    required this.scorePlayer2,
    required this.gameState,
  });

  Widget _buildScoreboardPlayer(
    String name,
    int totalScore,
    int plusPoints,
    bool scored,
    bool isPlayer1,
  ) {
   return Text.rich(
    softWrap: true,
    TextSpan(
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      children: [
        if (isPlayer1)
          TextSpan(
            text: "$name : ",
            style: TextStyle(color: gameState.givePlayerColor(1)),
          ),
        TextSpan(
          text: "$totalScore",
          style: TextStyle(
            color: scored ? Colors.green : Colors.black,
            fontSize: 22,
          ),
        ),
        if (!isPlayer1)
          TextSpan(
            text: " : $name",
            style: TextStyle(color: gameState.givePlayerColor(2)),
          ),
      ],
    ),
  );
  }

  Widget _buildPlusPoints(int plusPoints, bool scored) {
    return AnimatedOpacity(
      opacity: scored ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Text(
        "+$plusPoints",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gameState.isScoreUpdatedNotifier,
      builder: (context, isUpdated, child) {
        bool p1JustScored = isUpdated && gameState.currentPlayer == 2;
        bool p2JustScored = isUpdated && gameState.currentPlayer == 1;

        return Center(
          child: Table(
            //border: TableBorder.all(color: Colors.black),
            defaultColumnWidth: IntrinsicColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,

            children: [
              TableRow(
                children: [
                  _buildScoreboardPlayer(
                    player1Name,
                    gameState.scorePlayer1,
                    gameState.points,
                    p1JustScored,
                    true,
                  ),

                  Text(
                    " vs ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  _buildScoreboardPlayer(
                    player2Name,
                    gameState.scorePlayer2,
                    gameState.points,
                    p2JustScored,
                    false,
                  ),
                ],
              ),
              TableRow(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildPlusPoints(gameState.points, p1JustScored),
                  ),
                  const SizedBox.shrink(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildPlusPoints(gameState.points, p2JustScored),
                  ),
                ],
              ),
            ],
          ),
        );

      },
    );
  }
}
