import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:midterm_app/controllers/flashcardqa_controller.dart';
import 'package:midterm_app/pages/6flashcard.dart';

import 'package:midterm_app/pages/9flashbox.dart';
import 'package:midterm_app/pages/flashcardqa_model.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/listfc_model.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';

class FlashcardqaPage extends StatefulWidget {
  @override
  _FlashcardqaPageState createState() => _FlashcardqaPageState();
}

class _FlashcardqaPageState extends State<FlashcardqaPage> {
  List<Flashcardqa> flashcardqas = List.empty();
  List<Listfc> listfcs = List.empty();
  bool isLoading = false;
  var services = FirebaseServices();
  var controller;
  int number = 1;
  int _index = 0;
  double progress = 0;

  void initState() {
    super.initState();
    controller = FlashcardqaController(services);
    controller.onSync.listen(
      (bool syncState) => setState(() => isLoading = syncState),
    );
  }

  void _getFlashcardqas() async {
    var newFlashcardqas = await controller.fetchFlashcardqas();

    setState(() => flashcardqas = newFlashcardqas);
  }

  /*void _getListfcs() async {
    var newListfcs = await controller.fetchListfcs();

    setState(() => listfcs = newListfcs);
  }*/

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
                      SizedBox(height: 25),
                      Text(
                        '$number/${flashcardqas.length}',
                        style: TextStyle(fontSize: 16, fontFamily: "Nunito"),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: 250,
                        height: 10,
                        child: LinearProgressIndicator(
                          value: progress,
                          valueColor:
                              AlwaysStoppedAnimation(Colors.orange[200]),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
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
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: Previous,
                              child: Text(
                                'Prev',
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                elevation: 4,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: Next,
                              child: Text(
                                'Next',
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                elevation: 4,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            );
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
          style: TextStyle(fontSize: 22, fontFamily: "Nunito"),
        ),
        content: Text(
          'Do you want to start it again?',
          style: TextStyle(fontSize: 16, fontFamily: "Nunito"),
        ),
        actions: [
          CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/8', ModalRoute.withName('/Home'))),
          CupertinoDialogAction(
              child: Text('Exit'),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/Home', (route) => false)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard'),
      ),
      body: Center(child: body),
      floatingActionButton: FloatingActionButton(
        onPressed: _getFlashcardqas,
        child: Icon(Icons.play_arrow),
      ),
      /*ElevatedButton(
        onPressed: _getListfcs,
        child: Icon(Icons.play_arrow),
      ),*/
    );
  }
}
