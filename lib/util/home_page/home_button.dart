import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;

  const HomeButton({required this.title, required this.color, required this.borderColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor.withOpacity(0.5), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Icon(Icons.speed, size: 50, color: borderColor),
          ],
        ),
      ),
    );
  }
}