import 'package:flutter/material.dart';
import 'package:wavelength/util/wheel.dart';

class PsychicSpin extends StatefulWidget {
  final VoidCallback nextStep;
  const PsychicSpin({super.key, required this.nextStep});

  @override
  State<PsychicSpin> createState() => _PsychicSpinState();
}

class _PsychicSpinState extends State<PsychicSpin> {

  @override
  Widget build(BuildContext context) {
    return Wheel(phase: "psychic_spin");
  }
}
