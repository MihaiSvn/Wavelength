import 'package:flutter/material.dart';

class CoverController extends ChangeNotifier {
  double _turns = 0.0;
  double get turns => _turns;

  void toggleCover() {
    _turns = -0.5;
  }
}
