import 'package:flutter/material.dart';
import 'package:wavelength/pages/debug_wheel_page.dart';
import 'package:wavelength/pages/game_page.dart';
import 'package:wavelength/pages/home_page.dart';
import 'package:wavelength/pages/players_page.dart';
import 'package:wavelength/models/game_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wavelength',
      home: HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == "/home") {
          return MaterialPageRoute(builder: (context) => const HomePage());
        } else if (settings.name == "/players_page") {
          final String mode = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => PlayersPage(gameMode: mode),
          );
        } else if (settings.name == "/game_page") {
          final GameSettings args = settings.arguments as GameSettings;
          return MaterialPageRoute(
            builder: (context) => GamePage(settings: args),
          );
        } else if(settings.name == "/debug_wheel"){
          return MaterialPageRoute(
            builder: (context) => DebugWheelPage(),
          );
        }
        return null;
      },
    );
  }
}
