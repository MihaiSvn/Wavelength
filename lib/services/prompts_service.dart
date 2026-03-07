import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wavelength/models/prompt_model.dart';

class PromptsService {
  final String remoteUrl =
      'https://raw.githubusercontent.com/MihaiSvn/TBD/refs/heads/main/prompts.json';
  static List<dynamic>? _sessionCache;

  Future<List<dynamic>> fetchPrompts() async {
    // bool cacheIsOld = true;

    // if (await file.exists()) {
    //   DateTime lastModified = await file.lastModified();
    //   DateTime now = DateTime.now();

    //   if (now.difference(lastModified).inHours < 24) {
    //     cacheIsOld = false;
    //   }
    // }
    if (_sessionCache != null && _sessionCache!.isNotEmpty) {
      return _sessionCache!;
    }
    try {
      final response = await http.get(Uri.parse(remoteUrl));
      if (response.statusCode == 200) {
        //await file.writeAsString(response.body);

        final Map<String, dynamic> decodedData = json.decode(response.body);
        final List<dynamic> promptsList = decodedData['prompts'];
        print(promptsList[1]);
        _sessionCache = promptsList
            .map((item) => Prompt.fromJson(item))
            .toList();
        print(_sessionCache);
        return _sessionCache!;
      }
    } catch (e) {
      print("Offline sau eroare: $e");
    }
    return await loadFromAssets();
  }

  Future<List<dynamic>> loadFromAssets() async {
    try {
      final String assetsContent = await rootBundle.loadString(
        'assets/cache/prompts.json',
      );
      final List<dynamic> assetsDecoded = json.decode(assetsContent)['prompts'];
      print(assetsDecoded);
      return assetsDecoded.map((item) => Prompt.fromJson(item)).toList();
    } catch (e) {
      print("Error at cache: $e");
    }
    return [
      {"id": 1, "left": "Addictive", "right": "Boring"},
      {"id": 2, "left": "Cold", "right": "Hot"},
      {"id": 3, "left": "Weird", "right": "Normal"},
      {"id": 4, "left": "Colorful", "right": "Colorless"},
      {"id": 5, "left": "Expensive", "right": "Cheap"},
      {"id": 6, "left": "Good pet", "right": "Bad pet"},
      {"id": 7, "left": "Impressive skill", "right": "Useless skill"},
      {"id": 8, "left": "Overrated", "right": "Underrated"},
      {
        "id": 9,
        "left": "Useful in an emergency",
        "right": "Useless in an emergency",
      },
      {"id": 10, "left": "Smells good", "right": "Smells bad"},
      {"id": 11, "left": "Stressful", "right": "Relaxing"},
      {"id": 12, "left": "Mainstream", "right": "Niche"},
      {"id": 13, "left": "Historical", "right": "Futuristic"},
      {"id": 14, "left": "Hard to spell", "right": "Easy to spell"},
      {"id": 15, "left": "Fictional", "right": "Real"},
      {"id": 16, "left": "High maintenance", "right": "Low maintenance"},
      {"id": 17, "left": "Unhealthy", "right": "Healthy"},
      {"id": 18, "left": "For adults", "right": "For kids"},
      {"id": 19, "left": "Art", "right": "Not art"},
      {"id": 20, "left": "Dangerous", "right": "Safe"},
    ];
  }
}
