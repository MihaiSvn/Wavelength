import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const NextButton({
    super.key, 
    required this.onPressed, 
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
                shadowColor: Colors.pinkAccent.withOpacity(0.5),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing:
                      2,
                ),
              ),
            ),
    );
  }
}