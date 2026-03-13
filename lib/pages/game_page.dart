import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
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
  late final GameState gameState;
  //TurnPhases currentPhase = TurnPhases.showTurn;
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
      switch (gameState.currentPhase) {
        case TurnPhases.showTurn:
          gameState.nextPhase(TurnPhases.psychicSpin);
          gameState.updateTurn(0.0);
          gameState.updateNeedleTurn(0.0);

          break;
        case TurnPhases.psychicSpin:
          playerThatStartedThisPhase == 1
              ? gameState.switchPlayer(2)
              : gameState.switchPlayer(1);
          gameState.nextPhase(TurnPhases.guesserTurn);
          break;
        case TurnPhases.guesserTurn:
          gameState.nextPhase(TurnPhases.guesserGuess);
          break;
        case TurnPhases.guesserGuess:
          //logic to update score also
          turnCycle++;
          if (turnCycle > turnsPerPrompt) {
            gameState.switchPlayer(1); //start next round with first player
            gameState.nextPrompt();
            playerThatStartedThisPhase = gameState.currentPlayer;
            currentRound++;
            turnCycle = 1;
            if (currentRound > totalRounds) {
              gameState.nextPhase(TurnPhases.finalScreen);
              break;
            }
            gameState.nextPhase(TurnPhases.showTurn);
            break;
          }

          playerThatStartedThisPhase == 1
              ? gameState.switchPlayer(2)
              : gameState.switchPlayer(
                  1,
                ); //if the phase was started by player1, player2 will start the next phase and vice versa
          playerThatStartedThisPhase = gameState.currentPlayer;
          gameState.nextPhase(TurnPhases.showTurn);
          break;
        case TurnPhases.finalScreen:
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
        default:
          break;
      }
    });
  }

  int currentRound = 1, turnCycle = 1;
  int playerThatStartedThisPhase = 1;
  late String player1Name, player2Name;
  late int turnsPerPrompt, totalRounds;
  @override
  void initState() {
    super.initState();
    player1Name = widget.settings.player1Name;
    player2Name = widget.settings.player2Name;
    totalRounds = widget.settings.totalRounds;
    turnsPerPrompt =
        widget.settings.turnsPerPrompt *
        2; //because one turn means both players play as both roles
    gameState = GameState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: currentRound <= widget.settings.totalRounds
            ? Text("Round $currentRound / ${widget.settings.totalRounds}")
            : null,
        leading: IconButton(
          onPressed: () => confirmAlert(),
          icon: Icon(Icons.close),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF2E1A47), Color(0xFF0F0F1A)],
          ),
        ),

        child: SafeArea(child: phaseUI()),
      ),
    );
  }

  Widget phaseUI() {
    switch (gameState.currentPhase) {
      case TurnPhases.showTurn:
        return TurnViewer(
          settings: widget.settings,
          gameState: gameState,
          nextStep: nextStep,
        );
      case TurnPhases.psychicSpin:
        return PsychicSpin(
          settings: widget.settings,
          gameState: gameState,
          nextStep: nextStep,
        );
      case TurnPhases.guesserTurn:
        return TurnViewer(
          settings: widget.settings,
          gameState: gameState,
          nextStep: nextStep,
        );
      case TurnPhases.guesserGuess:
        return GuessSpin(
          settings: widget.settings,
          gameState: gameState,
          nextStep: nextStep,
        );
      case TurnPhases.finalScreen:
        return FinalScreen(
          nextStep: nextStep,
          gameState: gameState,
          settings: widget.settings,
        );
      default:
        return FinalScreen(
          nextStep: nextStep,
          gameState: gameState,
          settings: widget.settings,
        );
    }
  }
}
