import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/pages/game_phases/wheel_phases_template.dart';

class GuessSpin extends StatelessWidget {
  final GameSettings settings;
  final GameState gameState;
  final VoidCallback nextStep;
  const GuessSpin({
    super.key,
    required this.settings,
    required this.gameState,
    required this.nextStep,
  });

  @override
  Widget build(BuildContext context) {
    return WheelPhasesTemplate(
      settings: settings,
      gameState: gameState,
      nextStep: nextStep,
    );
  }
}
