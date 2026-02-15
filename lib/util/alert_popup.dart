import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  final String title;
  final String text;
  const AlertPopup({super.key, required this.title, required this.text});

  static void showPopup(BuildContext context, {required String title, required String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertPopup(title: title, text: text);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("OK")),
      ],
    );
  }
}