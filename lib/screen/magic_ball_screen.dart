import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import 'package:surf_practice_magic_ball/api/api_service.dart';

import '../widgets/footer.dart';
import '../widgets/responses.dart';
import '../widgets/rotating-object.dart';
import '../widgets/show_answer.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<String> serverResponses = MagicBallResponses.serverResponses;
  Map<String, String> replacements = getReplacements();

  String responseText = '';
  bool tapped = false;
  bool isFetchingData = false;
  EightBallApi eightBallApi = EightBallApi();
  footer footerb = footer();

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 50),
      vsync: this,
    );
    _controller.repeat();
    super.initState();

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        onTap();
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 1000,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    detector.startListening();
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
                ? AnswerClass(
                    responseTextShow: showText,
                    controller: _controller,
                  )
                : RotatingObject(controller: _controller),
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
          footer(),
        ],
      ),
    );
  }

  void onTap() {
    if (!isFetchingData) {
      setState(() {
        tapped = true;
        isFetchingData = true;
      });

      setState(() {
        responseText = getRandomResponse();
        isFetchingData = false;
        showText = getRandomResponse();
      });
      footerb.speak(showText);
    }
  }

  String showText = '';

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
}
