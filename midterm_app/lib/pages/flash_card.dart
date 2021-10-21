import 'package:flutter/cupertino.dart';
import 'package:midterm_app/main.dart';
import 'package:midterm_app/pages/card_storage.dart';
import 'package:midterm_app/pages/flashbox.dart';
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
  int number = 1;
  int _currentIndex = 0;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flashcards"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$number/${_cards.length}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 200,
                height: 10,
                child: LinearProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation(Colors.orange[200]),
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 5),
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

//เลื่อนไปดู flashcard อันถัดไป
  void Next() {
    setState(() {
      if (_currentIndex + 1 >= _cards.length) {
        progress = (_currentIndex + 1) / _cards.length;
        End();
      } else {
        _currentIndex = _currentIndex + 1;
        number = number + 1;
        progress = (_currentIndex + 1) / _cards.length;
      }
    });
  }

//ย้อนมาดู flashcard อันก่อนหน้า
  void Previous() {
    setState(() {
      if (_currentIndex - 1 < 0) {
        _currentIndex = 0;
      } else {
        _currentIndex = _currentIndex - 1;
        number = number - 1;
        progress = (_currentIndex + 1) / _cards.length;
      }
    });
  }

  void End() {
    showCupertinoDialog(
      context: context,
      builder: createDialog,
    );
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'You have checked all words.',
          style: TextStyle(fontSize: 22),
        ),
        content: Text(
          'Do you want to start it again?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/2', ModalRoute.withName('/5'))),
          CupertinoDialogAction(
              child: Text('Exit'),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/5', (route) => false)),
        ],
      );
}
