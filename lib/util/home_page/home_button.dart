import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const HomeButton({super.key,required this.buttonText,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(buttonText));
  }
}