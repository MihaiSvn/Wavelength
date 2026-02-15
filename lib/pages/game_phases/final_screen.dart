import 'package:flutter/material.dart';

class FinalScreen extends StatelessWidget {
  final VoidCallback nextStep;
  const FinalScreen({super.key, required this.nextStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Final screen"),
        ElevatedButton(onPressed: nextStep, child: Text("NEXT")),
      ],
    );
  }
}