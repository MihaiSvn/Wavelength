import 'package:flutter/material.dart';

class PsychicSpin extends StatelessWidget {
  final VoidCallback nextStep;
  const PsychicSpin({super.key, required this.nextStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Psychic spin"),
        ElevatedButton(onPressed: nextStep, child: Text("NEXT")),
      ],
    );
  }
}