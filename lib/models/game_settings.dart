class GameSettings {
  String player1Name, player2Name;
  int totalRounds, turnsPerPrompt;
  String mode;

  GameSettings({
    required this.player1Name,
    required this.player2Name,
    required this.totalRounds,
    required this.turnsPerPrompt,
    required this.mode,
  });
}
