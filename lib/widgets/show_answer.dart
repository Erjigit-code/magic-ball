import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';

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
