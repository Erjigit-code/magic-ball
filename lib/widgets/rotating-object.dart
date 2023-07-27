import 'package:flutter/material.dart';

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
