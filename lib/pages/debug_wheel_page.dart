import 'package:flutter/material.dart';
import 'package:wavelength/pages/game_phases/debug_wheel_template.dart';

class DebugWheelPage extends StatelessWidget {
  const DebugWheelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DEBUG"), centerTitle: true,),
      body: DebugWheelTemplate(),
    );
  }
}