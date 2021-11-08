import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:midterm_app/pages/9flashbox.dart';
import 'package:provider/provider.dart';

class FlashCard extends StatefulWidget {
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Play Flash Card"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/cards_bg.png"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Consumer<FormModel>(
                    builder: (context, model, child) {
                      return SizedBox(
                        width: 300,
                        height: 350,
                        child: model.Questions.length > 0
                            ? FlipCard(
                                front: FlashcardBox(
                                  vocab: model.Questions[_currentIndex],
                                ),
                                back: FlashcardBox(
                                  vocab: model.Answers[_currentIndex],
                                ),
                              )
                            : const Center(
                                child: Text(
                                  "No Card",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (context.read<FormModel>().Questions.length > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                        child: Icon(Icons.chevron_left, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          elevation: 4,
                        ),
                        onPressed: Previous,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                        child: Icon(Icons.chevron_right, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          elevation: 4,
                        ),
                        onPressed: Next,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

//เลื่อนไปดู flashcard อันถัดไป
  void Next() {
    setState(() {
      _currentIndex =
          (_currentIndex != context.read<FormModel>().Questions.length - 1)
              ? _currentIndex + 1
              : _currentIndex;
    });
  }

//ย้อนมาดู flashcard อันก่อนหน้า
  void Previous() {
    setState(() {
      _currentIndex = (_currentIndex != 0) ? _currentIndex - 1 : 0;
    });
  }
}
