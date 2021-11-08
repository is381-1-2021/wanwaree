import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:midterm_app/controllers/flashcardqa_controller.dart';
import 'package:midterm_app/pages/9flashbox.dart';
import 'package:midterm_app/pages/flashcardqa_model.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';

var services = FirebaseServices();
var controller = FlashcardqaController(services);

class FlashcardqaPage extends StatefulWidget {
  final FlashcardqaController controller;

  FlashcardqaPage({required this.controller});
  @override
  _FlashcardqaPageState createState() => _FlashcardqaPageState();
}

class _FlashcardqaPageState extends State<FlashcardqaPage> {
  List<Flashcardqa> flashcardqas = List.empty();
  bool isLoading = false;
  int number = 1;
  int _index = 0;
  double progress = 0;

  void initState() {
    super.initState();

    widget.controller.onSync.listen(
      (bool syncState) => setState(() => isLoading = syncState),
    );
  }

  void _getFlashcardqas() async {
    var newFlashcardqas = await widget.controller.fetchFlashcardqas();

    setState(() => flashcardqas = newFlashcardqas);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: flashcardqas.isEmpty ? 1 : 1,
          itemBuilder: (ctx, index) {
            if (flashcardqas.isEmpty) {
              return Container(
                alignment: FractionalOffset.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Text(
                    "Please click the button to play flashcard",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 18,
                        fontFamily: "Nunito"),
                  ),
                ),
              );
            }

            return /*Scaffold(
                appBar: AppBar(
                  title: Text("My Flashcards"),
                ),
                body:*/
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$number/${flashcardqas.length}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: 200,
                              height: 10,
                              child: LinearProgressIndicator(
                                value: progress,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange[200]),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                                width: 300,
                                height: 350,
                                child: FlipCard(
                                    front: FlashcardBox(
                                      vocab: flashcardqas[_index].question,
                                    ),
                                    back: FlashcardBox(
                                      vocab: flashcardqas[_index].answer,
                                    ))),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: Previous,
                                    child: Icon(Icons.chevron_left,
                                        color: Colors.white)),
                                ElevatedButton(
                                    onPressed: Next,
                                    child: Icon(Icons.chevron_right,
                                        color: Colors.white))
                              ],
                            )
                          ],
                        )));
          },
        );

//เลื่อนไปดู flashcard อันถัดไป
  void Next() {
    setState(() {
      if (_index + 1 >= flashcardqas.length) {
        progress = (_index + 1) / flashcardqas.length;
        End();
      } else {
        _index = _index + 1;
        number = number + 1;
        progress = (_index + 1) / flashcardqas.length;
      }
    });
  }

//ย้อนมาดู flashcard อันก่อนหน้า
  void Previous() {
    setState(() {
      if (_index - 1 < 0) {
        _index = 0;
      } else {
        _index = _index - 1;
        number = number - 1;
        progress = (_index + 1) / flashcardqas.length;
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
            onPressed: () {},
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eng'),
      ),
      body: Center(child: body),
      floatingActionButton: FloatingActionButton(
        onPressed: _getFlashcardqas,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
