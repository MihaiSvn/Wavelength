import 'package:flutter/material.dart';

class BirthdayDialog {
  static void show(BuildContext context, int age) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BirthdayDialog",
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 600),

      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: AlertDialog(
            backgroundColor: const Color(0xFF1E1E2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.pinkAccent, width: 2),
            ),
            title: const Text(
              "HAPPY BIRTHDAY",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "HAPPY ${age}st BIRTHDAY!",
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/candy.png",
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Thanks!",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },

      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
    );
  }
}
