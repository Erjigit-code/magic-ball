import 'package:flutter/material.dart';

class ShowAnswer extends StatelessWidget {
  final String responseTextShow;

  const ShowAnswer({super.key, required this.responseTextShow});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/ball-dark.png'),
        Image.asset('assets/images/Vector2.png'),
        SizedBox(
          width: 243,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              responseTextShow, // Display the translated response from the API
              textAlign: TextAlign.center,
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 32,
                fontFamily: 'Sans',
                fontWeight: FontWeight.w400,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
