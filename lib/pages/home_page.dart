import 'package:flutter/material.dart';
import 'package:wavelength/controllers/game_state.dart';
import 'package:wavelength/util/home_page/dev_button.dart';
import 'package:wavelength/util/home_page/home_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  void _navigateTo(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF2E1A47), Color(0xFF0F0F1A)],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.orangeAccent, Colors.pinkAccent, Colors.cyanAccent],
                      ).createShader(bounds),
                      child: const Text(
                        "WAVELENGTH",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text("PLAY MODES", style: TextStyle(color: Colors.white54, letterSpacing: 1.5)),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeButton(
                              title: "CLASSIC\nMODE",
                              color: Colors.cyanAccent.withOpacity(0.2),
                              borderColor: Colors.cyanAccent,
                              onTap: () => _navigateTo(context, '/players_page', arguments: "Classic"),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: HomeButton(
                              title: "CUSTOM\nMODE",
                              color: Colors.orangeAccent.withOpacity(0.2),
                              borderColor: Colors.orangeAccent,
                              onTap: () => _navigateTo(context, '/players_page', arguments: "Custom"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),
                    const Text("DEVELOPER TOOLS", style: TextStyle(color: Colors.white30, fontSize: 12)),
                    const SizedBox(height: 15),

                    DevButton(
                      label: "DEBUG WHEEL",
                      onPressed: () => _navigateTo(context, "/debug_wheel", arguments: GameState()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}