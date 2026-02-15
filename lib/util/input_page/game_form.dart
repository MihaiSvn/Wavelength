import 'package:flutter/material.dart';
import 'package:wavelength/util/alert_popup.dart';
import 'package:wavelength/util/input_page/digit_form.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/util/input_page/player_name_form.dart';

class GameForm extends StatefulWidget {
  final String gameMode;
  const GameForm({super.key, required this.gameMode});

  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  String? errorText;
  TextEditingController controllerPlayer1 = TextEditingController();
  TextEditingController controllerPlayer2 = TextEditingController();
  TextEditingController controllerRounds = TextEditingController();
  TextEditingController controllerSwaps = TextEditingController();

  int minRounds = 1;
  int maxRounds = 20;

  int minSwaps = 1;
  int maxSwaps = 10;

  void validateInput() {
    bool ok = true;
    String name1 = controllerPlayer1.text;
    String name2 = controllerPlayer2.text;

    if (name1.isNotEmpty && name2.isNotEmpty) {
      final numberRounds = int.tryParse(controllerRounds.text);
      if (numberRounds == null ||
          numberRounds < minRounds ||
          numberRounds > maxRounds) {
        ok = false;
        AlertPopup.showPopup(
          context,
          title: "Alert",
          text:
              "You must set the number of round to a numeric value between $minRounds and $maxRounds!",
        );
      }
      final numberSwaps = int.tryParse(controllerSwaps.text);
      if (numberSwaps == null ||
          numberSwaps < minSwaps ||
          numberSwaps > maxSwaps) {
        ok = false;
        AlertPopup.showPopup(
          context,
          title: "Alert",
          text:
              "You must set the number of swaps to a numeric value between $minSwaps and $maxSwaps!",
        );
      }
    } else {
      ok = false;
      AlertPopup.showPopup(
        context,
        title: "Alert",
        text: "You must set the names of the players!",
      );
    }
    if (ok) {
      final settings = GameSettings(
        player1Name: name1,
        player2Name: name2,
        totalRounds: int.parse(controllerRounds.text),
        turnsPerPrompt: int.parse(controllerSwaps.text),
        mode: widget.gameMode,
      );
      Navigator.pushNamed(context, '/game_page', arguments: settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PlayerNameForm(
                playerIndex: 1,
                controller: controllerPlayer1,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: PlayerNameForm(
                playerIndex: 2,
                controller: controllerPlayer2,
              ),
            ),
          ],
        ),
        Column(
          children: [
            DigitForm(
              minVal: minRounds,
              maxVal: maxRounds,
              label: "Number of rounds",
              controller: controllerRounds,
            ),
            DigitForm(
              minVal: minSwaps,
              maxVal: maxSwaps,
              label: "Swaps per prompt",
              controller: controllerSwaps,
            ),
          ],
        ),
        ElevatedButton(onPressed: validateInput, child: Text("Start game")),
      ],
    );
  }
}
