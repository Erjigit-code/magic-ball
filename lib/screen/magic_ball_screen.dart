import 'dart:math';

import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import 'package:surf_practice_magic_ball/api/api_service.dart';

import '../widgets/footer.dart';
import '../widgets/responses.dart';
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

class RotatingObject extends StatelessWidget {
  const RotatingObject({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/ball.png'),
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: Image.asset(
            'assets/images/smallstar.png',
          ),
        ),
        RotationTransition(
          turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
          child: Image.asset('assets/images/star.png'),
        ),
      ],
    );
  }
}

class AnswerClass extends StatefulWidget {
  final String responseTextShow;
  const AnswerClass({
    super.key,
    required AnimationController controller,
    required this.responseTextShow,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  State<AnswerClass> createState() => _AnswerClassState();
}

class _AnswerClassState extends State<AnswerClass> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/ball.png'),
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(widget._controller),
          child: Image.asset(
            'assets/images/smallstar.png',
          ),
        ),
        RotationTransition(
          turns: Tween(begin: 1.0, end: 0.0).animate(widget._controller),
          child: Image.asset(
            'assets/images/star.png',
            width: 200,
            height: 200,
          ),
        ),
        Image.asset('assets/images/black.png'),
        SizedBox(
          width: 243,
          child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: AnimatedStringText(
                widget.responseTextShow,
                textAlign: TextAlign.center,
                duration: Duration(milliseconds: 700),
                curve: Curves.decelerate,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontFamily: 'Sans',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 252, 250, 252)),
              )),
        ),
      ],
    );
  }
}
