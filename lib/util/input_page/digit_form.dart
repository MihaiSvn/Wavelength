import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wavelength/util/alert_popup.dart';

class DigitForm extends StatefulWidget {
  final int minVal;
  final int maxVal;
  final String label;
  final TextEditingController controller;
  const DigitForm({
    super.key,
    required this.minVal,
    required this.maxVal,
    required this.label,
    required this.controller,
  });

  @override
  State<DigitForm> createState() => _DigitFormState();
}

class _DigitFormState extends State<DigitForm> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (text) {
        final value = int.tryParse(text);
        setState(() {
          if (value == null || value < widget.minVal || value > widget.maxVal) {
            errorText = "Must be between ${widget.minVal} and ${widget.maxVal}";
          } else {
            errorText = null;
          }
        });
      },
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: errorText,
        suffixIcon: IconButton(
          onPressed: () {
            AlertPopup.showPopup(
              context,
              title: "Info",
              text:
                  "Set the number of prompts you'll get in a game and how many times the Psychic and Guesser roles swap for each prompt. For example, if 'Swaps for prompt' is set to 2, both players will get to be the Psychic twice for the same card before a new prompt is shown.",
            );
          },
          icon: Icon(Icons.info_outline),
        ),
      ),
    );
  }
}
