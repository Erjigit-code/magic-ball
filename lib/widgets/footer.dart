import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class footer extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  footer({
    super.key,
  });
  speak(String soundMsg) async {
    await flutterTts.setLanguage('ru-RU');
    await flutterTts.setPitch(1);
    await flutterTts.speak(soundMsg);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: 175,
        height: 50,
        child: const Text(
          "Нажмите на шар или потрясите телефон",
          textAlign: TextAlign.center,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 16,
            fontFamily: 'Sans',
            fontWeight: FontWeight.w400,
            color: Color(0xFF727272),
          ),
        ),
      ),
    );
  }
}
