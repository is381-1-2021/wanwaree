import 'package:flashcard/pages/card_storage.dart';
import 'package:flashcard/pages/flashbox.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlashCard extends StatefulWidget {
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  List<FlashCardStore> _cards = [
    FlashCardStore(data1: "Soaring", data2: "เพิ่มขึ้นอย่างรวดเร็ว"),
    FlashCardStore(data1: "Substitution", data2: "การแทนที่"),
    FlashCardStore(data1: "Unveil", data2: "เปิดเผยตัว"),
    FlashCardStore(
        data1:
            "What country gifted the United States with the Statue of Liberty?",
        data2: "France")
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flashcard"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  height: 350,
                  child: FlipCard(
                      front: FlashcardBox(
                        vocab: _cards[_currentIndex].data1,
                      ),
                      back: FlashcardBox(
                        vocab: _cards[_currentIndex].data2,
                      ))),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: Previous,
                      child: Icon(Icons.chevron_left, color: Colors.white)),
                  ElevatedButton(
                      onPressed: Next,
                      child: Icon(Icons.chevron_right, color: Colors.white))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void Next() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1 < _cards.length) ? _currentIndex + 1 : 0;
    });
  }

  void Previous() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 >= _cards.length) ? _currentIndex - 1 : 0;
    });
  }
}
