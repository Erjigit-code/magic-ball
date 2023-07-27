import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen.dart';

class ShowAnswer extends StatefulWidget {
  final String responseTextShow;

  const ShowAnswer({super.key, required this.responseTextShow});

  @override
  State<ShowAnswer> createState() => _ShowAnswerState();
}

class _ShowAnswerState extends State<ShowAnswer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Image.asset('assets/images/ball-dark.png'),
        // Image.asset(
        //   'assets/images/Vector.png',
        //   height: 200,
        //   width: 200,
        // ),
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
                    color: Color(0xff9923A2)),
              )
              // Text(
              //   responseTextShow, // Display the translated response from the API
              //   textAlign: TextAlign.center,
              // style: const TextStyle(
              //   decoration: TextDecoration.none,
              //   fontSize: 32,
              //   fontFamily: 'Sans',
              //   fontWeight: FontWeight.w400,
              //   color: Color(0xFFFFFFFF),
              // ),
              // ),
              ),
        ),
      ],
    );
  }
}
