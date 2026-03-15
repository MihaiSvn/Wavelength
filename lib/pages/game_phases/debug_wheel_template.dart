import 'package:flutter/material.dart';
import 'package:wavelength/controllers/cover_controller.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_phases.dart';
import 'package:wavelength/util/wheel.dart';

class DebugWheelTemplate extends StatefulWidget {
  const DebugWheelTemplate({super.key});

  @override
  State<DebugWheelTemplate> createState() => _DebugWheelTemplateState();
}

class _DebugWheelTemplateState extends State<DebugWheelTemplate> {
  bool isNextButtonVisible = false;
  void onNextButtonChanged() {
    setState(() {
      isNextButtonVisible = true;
    });
  }

  void onRevealCover() {
    setState(() {
      isNextButtonVisible = true;
    });
  }

  final TextEditingController _turnInputController = TextEditingController();
  void _applyManualTurn() {
    final double? newValue = double.tryParse(_turnInputController.text);
    //print(newValue);
    if (newValue != null) {
      setState(() {
        gameState.updateTurn(newValue);
      });
    }
  }

  TurnPhases phase = TurnPhases.debug;
  CoverController coverController = CoverController();
  late GameState gameState;
  @override
  void initState() {
    gameState = GameState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ListenableBuilder(
          listenable: gameState,
          builder: (context, child) {
            return Text(
              "Score: ${gameState.points}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          },
        ),
        Wheel(
          phase: phase,
          onChanged: onNextButtonChanged,
          controller: coverController,
          gameState: gameState,
          debug: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _turnInputController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Set Turn (0.0 - 1.0)",
                    hintText: "ex: 0.75",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _applyManualTurn,
                child: const Text("Apply"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
