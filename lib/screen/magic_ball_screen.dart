import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/api/api_service.dart';
import 'package:shake/shake.dart';
import 'dart:math';

import '../widgets/footer.dart';
import '../widgets/responses.dart';
import '../widgets/show_answer.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  List<String> formattedResponses = [];
  List<String> serverResponses = MagicBallResponses.serverResponses;
  Map<String, String> replacements = getReplacements();

  @override
  void initState() {
    super.initState();
    formatResponses();

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        if (!isFetchingData) {
          setState(() {
            tapped = true;
            isFetchingData = true;
          });
          final result = await eightBallApi.fetchData();
          final translatedResponse = replaceMultiple(result, replacements);
          setState(() {
            responseText = translatedResponse;
            isFetchingData = false;
          });
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    detector.startListening();
  }

  void formatResponses() {
    for (String response in serverResponses) {
      String editedResponse = replaceMultiple(response, replacements);
      formattedResponses.add(editedResponse);
    }
  }

  String responseText = '';
  bool tapped = false;
  bool isFetchingData = false;
  EightBallApi eightBallApi = EightBallApi();

  String getRandomResponse() {
    // Возвращаем пустую строку, если данные еще не загружены
    if (isFetchingData) {
      return "";
    }

    final random = Random();
    final randomIndex = random.nextInt(serverResponses.length);
    final randomResponse = serverResponses[randomIndex];
    return replacements[randomResponse] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff0E0A26),
            Color(0xff000000),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: tapped
                ? ShowAnswer(responseText: getRandomResponse())
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/ball-dark.png'),
                    ],
                  ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/Ellipse.png',
              ),
              Image.asset('assets/images/Ellipse2.png'),
            ],
          ),
          const footer(),
        ],
      ),
    );
  }

  String replaceMultiple(String text, Map<String, String> replacements) {
    for (var entry in replacements.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }
    return text;
  }

  void onTap() async {
    if (!isFetchingData) {
      setState(() {
        tapped = true;
        isFetchingData = true;
      });
      final result = await eightBallApi.fetchData();
      final translatedResponse = replaceMultiple(result, replacements);
      setState(() {
        responseText = translatedResponse;
        isFetchingData = false;
      });
    }
  }
}
