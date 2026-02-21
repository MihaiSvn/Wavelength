import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/pages/game_phases/wheel_phases_template.dart';

class PsychicSpin extends StatelessWidget {
  final GameSettings settings;
  final GameState gameState;
  final VoidCallback nextStep;
  const PsychicSpin({
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
