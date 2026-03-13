import 'package:flutter/material.dart';

class PromptsBar extends StatelessWidget {
  final String firstPrompt, lastPrompt;
  const PromptsBar({
    super.key,
    required this.firstPrompt,
    required this.lastPrompt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 30,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              softWrap: true,
              firstPrompt,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.2, color: Colors.white),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 2),
            child: Image.asset('assets/images/double-arrow.png', height: 40,color: Colors.white),
          ),
      
          Expanded(
            flex: 1,
            child: Text(
              softWrap: true,
              lastPrompt,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.2, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
