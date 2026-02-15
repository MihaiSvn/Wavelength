import 'package:flutter/material.dart';

class GuessSpin extends StatelessWidget {
  final VoidCallback nextStep;
  const GuessSpin({super.key, required this.nextStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Guess spin"),
        ElevatedButton(onPressed: nextStep, child: Text("NEXT")),
      ],
    );
  }
}