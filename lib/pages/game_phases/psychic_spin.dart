import 'package:flutter/material.dart';

class PsychicSpin extends StatelessWidget {
  final VoidCallback nextStep;
  const PsychicSpin({super.key, required this.nextStep});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/wheel.png'),
            Image.asset('assets/images/cover.png'),
            Image.asset('assets/images/frame.png'),
            Image.asset('assets/images/needle.png'),
          ],
        ),
      ),
    );
  }
}