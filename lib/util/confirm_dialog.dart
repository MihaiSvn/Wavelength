import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback confirmAction;
  const ConfirmDialog({super.key, required this.title, required this.text, required this.confirmAction});

  static void showPopup(BuildContext context, {required String title, required String text, required VoidCallback confirmAction}) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(title: title, text: text,confirmAction: confirmAction,);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(onPressed: confirmAction, child: Text("OK")),
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("CANCEL")),
      ],
    );
  }
}