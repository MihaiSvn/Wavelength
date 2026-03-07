class GameSettings {
  String player1Name, player2Name;
  int totalRounds, turnsPerPrompt;
  String mode;
  List<dynamic> allPrompts;

  GameSettings({
    required this.player1Name,
    required this.player2Name,
    required this.totalRounds,
    required this.turnsPerPrompt,
    required this.mode,
    required this.allPrompts,
  });

  int get totalPromptsCount => allPrompts.length;

  String currentPlayerToName(int index) {
    if (index == 1) {
      return player1Name;
    }
    return player2Name;
  }
}
