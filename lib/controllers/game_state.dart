import 'package:flutter/material.dart';
import 'package:wavelength/models/game_phases.dart';

class GameState extends ChangeNotifier {
  TurnPhases _currentPhase = TurnPhases.showTurn;
  int _currentPlayer = 1; //1 or 2
  int _scorePlayer1 = 0;
  int _scorePlayer2 = 0;
  int points = 0;
  double _wheelTurn = 0.0;
  double _needleTurn = 0.0;

  final ValueNotifier<Map<String, dynamic>?> pointsValueNotifier =
      ValueNotifier<Map<String, dynamic>?>(null);
  final ValueNotifier<bool> isScoreUpdatedNotifier = ValueNotifier<bool>(false);

  TurnPhases get currentPhase => _currentPhase;
  int get currentPlayer => _currentPlayer;
  int get scorePlayer1 => _scorePlayer1;
  int get scorePlayer2 => _scorePlayer2;
  double get wheelTurn => _wheelTurn;
  double get needleTurn => _needleTurn;

  void nextPhase(TurnPhases newPhase) {
    _currentPhase = newPhase;
    notifyListeners();
  }

  void triggerScoreHighlight() {
    isScoreUpdatedNotifier.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isScoreUpdatedNotifier.value = false;
    });
  }

  Color givePlayerColor(int player) {
    if (currentPlayer != player) {
      return Colors.black;
    }
    if (currentPhase == TurnPhases.psychicSpin || currentPhase == TurnPhases.showTurn) {  //if im on a spin screen or the psychic is being shown it's their turn, it will be pink
      return Colors.pinkAccent;
    }
    if (currentPhase == TurnPhases.guesserGuess || currentPhase == TurnPhases.guesserTurn) { //same logic, but for guesser give blue
      return Colors.blue;
    }
    return Colors.black;
  }

  void addPoint(int points) {
    currentPlayer == 1 ? _scorePlayer2 += points : _scorePlayer1 += points;
    pointsValueNotifier.value = {
      'player': currentPlayer == 1 ? 2 : 1,
      'points': points,
    };
    notifyListeners();
  }

  void switchPlayer(int player) {
    _currentPlayer = player;
    notifyListeners();
  }

  void updateTurn(double newTurn) {
    _wheelTurn = newTurn % 1.0;

    notifyListeners();
  }

  void updateNeedleTurn(double newTurn) {
    _needleTurn = newTurn;
    notifyListeners();
  }

  void updateScore() {
    Map<int, double> ranges = {4: 0.015, 3: 0.045, 2: 0.075};
    double symWheelTurn = (wheelTurn + 0.5) % 1.0;
    double difference = (_wheelTurn - _needleTurn).abs();
    double differenceSymetric = (symWheelTurn - _needleTurn).abs();
    if (difference > 0.5) {
      difference = 1.0 - difference;
    }
    if (differenceSymetric > 0.5) {
      differenceSymetric = 1.0 - differenceSymetric;
    }
    difference = difference.abs();
    differenceSymetric = differenceSymetric.abs();
    double finalDiff = difference < differenceSymetric
        ? difference
        : differenceSymetric;
    //int points = 0;
    if (finalDiff <= ranges[4]!) {
      points = 4;
    } else if (finalDiff <= ranges[3]!) {
      points = 3;
    } else if (finalDiff <= ranges[2]!) {
      points = 2;
    } else {
      points = 0;
    }

    //print("$wheelTurn $needleTurn $difference $differenceSymetric $points");
    addPoint(points);
    if (points != 0) triggerScoreHighlight();
  }
}
