import 'package:flutter/material.dart';
import 'package:wavelength/models/game_phases.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/pages/game_phases/final_screen.dart';
import 'package:wavelength/pages/game_phases/guess_spin.dart';
import 'package:wavelength/pages/game_phases/psychic_spin.dart';
import 'package:wavelength/pages/game_phases/turn_viewer.dart';
import 'package:wavelength/util/confirm_dialog.dart';

class GamePage extends StatefulWidget {
  final GameSettings settings;
  const GamePage({super.key, required this.settings});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  TurnPhases currentPhase = TurnPhases.showTurn;
  void confirmAlert() {
    ConfirmDialog.showPopup(
      context,
      title: "WARNING",
      text:
          "By exiting, you will lose progress of your current game. Are you sure you want to quit?",
      confirmAction: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      },
    );
  }

  void nextStep() {
    setState(() {
      switch (currentPhase) {
        case TurnPhases.showTurn:
          currentPhase = TurnPhases.psychicSpin;
          break;
        case TurnPhases.psychicSpin:
          currentPlayer = playerThatStartedThisPhase == player1Name
              ? player2Name
              : player1Name;
          currentPhase = TurnPhases.guesserTurn;
          break;
        case TurnPhases.guesserTurn:
          currentPhase = TurnPhases.guesserGuess;
          break;
        case TurnPhases.guesserGuess:
          //logic to update score also
          turnCycle++;
          if (turnCycle > turnsPerPrompt) {
            currentPlayer = player1Name; //start next round with first player
            playerThatStartedThisPhase = currentPlayer;
            currentRound++;
            turnCycle = 1;
            if (currentRound > totalRounds) {
              currentPhase = TurnPhases.finalScreen;
              break;
            }
            currentPhase = TurnPhases.showTurn;
            break;
          }

          currentPlayer = playerThatStartedThisPhase == player1Name
              ? player2Name
              : player1Name; //if the phase was started by player1, player2 will start the next phase and vice versa
          playerThatStartedThisPhase = currentPlayer;
          currentPhase = TurnPhases.showTurn;
          break;
        case TurnPhases.finalScreen:
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
      }
    });
  }

  int currentRound = 1, turnCycle = 1;
  int scorePlayer1 = 0, scorePlayer2 = 0;
  late String playerThatStartedThisPhase;
  late String currentPlayer;
  late String player1Name, player2Name;
  late int turnsPerPrompt, totalRounds;
  @override
  void initState() {
    super.initState();
    currentPlayer = widget.settings.player1Name;
    player1Name = widget.settings.player1Name;
    player2Name = widget.settings.player2Name;
    totalRounds = widget.settings.totalRounds;
    turnsPerPrompt =
        widget.settings.turnsPerPrompt *
        2; //because one turn means both players play as both roles
    playerThatStartedThisPhase = player1Name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Round $currentRound / ${widget.settings.totalRounds}"),
        leading: IconButton(
          onPressed: () => confirmAlert(),
          icon: Icon(Icons.close),
        ),
        centerTitle: true,
      ),
      body: phaseUI(),
    );
  }

  Widget phaseUI() {
    switch (currentPhase) {
      case TurnPhases.showTurn:
        return TurnViewer(
          player1Name: player1Name,
          player2Name: player2Name,
          currentPlayer: currentPlayer,
          scorePlayer1: scorePlayer1,
          scorePlayer2: scorePlayer2,
          nextStep: nextStep,
        );
      case TurnPhases.psychicSpin:
        return PsychicSpin(
          player1Name: player1Name,
          player2Name: player2Name,
          currentPlayer: currentPlayer,
          scorePlayer1: scorePlayer1,
          scorePlayer2: scorePlayer2,
          nextStep: nextStep,
        );
      case TurnPhases.guesserTurn:
        return TurnViewer(
          player1Name: player1Name,
          player2Name: player2Name,
          currentPlayer: currentPlayer,
          scorePlayer1: scorePlayer1,
          scorePlayer2: scorePlayer2,
          nextStep: nextStep,
        );
      case TurnPhases.guesserGuess:
        return GuessSpin(
          player1Name: player1Name,
          player2Name: player2Name,
          currentPlayer: currentPlayer,
          scorePlayer1: scorePlayer1,
          scorePlayer2: scorePlayer2,
          nextStep: nextStep,
        );
      case TurnPhases.finalScreen:
        return FinalScreen(nextStep: nextStep);
    }
  }
}
