import 'package:flutter/material.dart';
import 'package:wavelength/services/prompts_service.dart';
import 'package:wavelength/util/alert_popup.dart';
import 'package:wavelength/util/input_page/custom_prompts_form.dart';
import 'package:wavelength/util/input_page/digit_form.dart';
import 'package:wavelength/models/game_settings.dart';
import 'package:wavelength/util/input_page/player_name_form.dart';
import 'package:wavelength/util/next_button.dart';

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

  List<Map<String, TextEditingController>> customPromptsController = [
    {'left': TextEditingController(), 'right': TextEditingController()},
  ];

  int minRounds = 1;
  int maxRounds = 20;

  int minSwaps = 1;
  int maxSwaps = 10;

  Future<void> validateInput() async {
    bool ok = true;
    String name1 = controllerPlayer1.text;
    String name2 = controllerPlayer2.text;

    if (name1.isNotEmpty && name2.isNotEmpty) {
      if (widget.gameMode == "Classic") {
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
      } else if (widget.gameMode == "Custom") {
        if (customPromptsController.isEmpty) {
          ok = false;
          AlertPopup.showPopup(
            context,
            title: "Alert",
            text: "You must add at least one custom prompt!",
          );
        } else {
          for (var row in customPromptsController) {
            String leftText = row['left']!.text.trim();
            String rightText = row['right']!.text.trim();

            if (leftText.isEmpty || rightText.isEmpty) {
              ok = false;
              AlertPopup.showPopup(
                context,
                title: "Alert",
                text: "All custom prompts must have both sides filled!",
              );
              break;
            }
          }
        }
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
      PromptsService promptsService = PromptsService();
      List<dynamic> fetchedPrompts = [];
      try {
        if (widget.gameMode == 'Classic') {
          fetchedPrompts = await promptsService.fetchPrompts();
          fetchedPrompts.shuffle();
        } else if (widget.gameMode == "Custom") {
          fetchedPrompts = customPromptsController.map((row) {
            return {
              "id":
                  DateTime.now().millisecondsSinceEpoch +
                  customPromptsController.indexOf(row),
              "left": row['left']!.text.trim(),
              "right": row['right']!.text.trim(),
            };
          }).toList();
        }
        if (!mounted) return;

        final settings = GameSettings(
          player1Name: name1,
          player2Name: name2,
          totalRounds: widget.gameMode == "Custom"
              ? fetchedPrompts.length
              : int.parse(controllerRounds.text),
          turnsPerPrompt: int.parse(controllerSwaps.text),
          mode: widget.gameMode,
          allPrompts: fetchedPrompts,
        );
        Navigator.pushNamed(context, '/game_page', arguments: settings);
      } catch (e) {
        AlertPopup.showPopup(
          context,
          title: "Error",
          text: "Could not load prompts: $e",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int dynamicMaxLength = (screenWidth / 35).floor();

    if (dynamicMaxLength < 7) dynamicMaxLength = 7;
    if (dynamicMaxLength > 20) dynamicMaxLength = 20;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 17,
        children: [
          Row(
            children: [
              Expanded(
                child: PlayerNameForm(
                  playerIndex: 1,
                  maxLength: dynamicMaxLength,
                  controller: controllerPlayer1,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: PlayerNameForm(
                  playerIndex: 2,
                  maxLength: dynamicMaxLength,
                  controller: controllerPlayer2,
                ),
              ),
            ],
          ),
          Column(
            spacing: 17,
            children: [
              if (widget.gameMode == "Classic")
                DigitForm(
                  minVal: minRounds,
                  maxVal: maxRounds,
                  label: "Number of rounds",
                  controller: controllerRounds,
                )
              else
                CustomPromptsForm(
                  minVal: minRounds,
                  maxVal: maxRounds,
                  controller: customPromptsController,
                ),
              DigitForm(
                minVal: minSwaps,
                maxVal: maxSwaps,
                label: "Swaps per prompt",
                controller: controllerSwaps,
              ),
            ],
          ),
          NextButton(onPressed: validateInput, label: "START GAME")
        ],
      ),
    );
  }
}
