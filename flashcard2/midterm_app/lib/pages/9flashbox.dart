import 'package:flutter/material.dart';

//เอาไว้เรียกใช้ Card จะได้แก้ไขที่เดียว
class FlashcardBox extends StatelessWidget {
  final String vocab;

  FlashcardBox({Key? key, required this.vocab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Center(
          child: Text(
            vocab,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
