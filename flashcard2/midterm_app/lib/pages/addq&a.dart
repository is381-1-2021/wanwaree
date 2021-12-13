import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_app/controllers/listfc_controller.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:midterm_app/pages/6flashcard.dart';
import 'package:midterm_app/pages/listfc_model.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:midterm_app/pages/9flashbox.dart';

class ListfcPage extends StatefulWidget {
  @override
  _ListfcPageState createState() => _ListfcPageState();
}

class _ListfcPageState extends State<ListfcPage> {
  List<Listfc> listfcs = List.empty();
  bool isLoading = false;
  var services = FirebaseServices();
  var controller;
  int number = 1;
  int _index = 0;

  double progress = 0;

  int _pageState = 0;

  double _popupWidth = 0;
  double _popupHeight = 0;

  double _popupYOffset = 0;
  double _popupXOffset = 0;

  double wdWidth = 0;
  double wdheight = 0;

  final _formkey3 = GlobalKey<FormState>();
  Formqa fcqanda = Formqa();
  CollectionReference _fcqandaCollection =
      FirebaseFirestore.instance.collection("fc_flashcardqa");

  void initState() {
    super.initState();
    controller = ListfcController(services);

    controller.onSync.listen(
      (bool syncState) => setState(() => isLoading = syncState),
    );
  }

  void _getListfcs() async {
    var newListfcs = await controller.fetchListfcs();

    setState(() => listfcs = newListfcs);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: listfcs.isEmpty ? 1 : listfcs.length,
          itemBuilder: (ctx, index) {
            if (listfcs.isEmpty) {
              return Container(
                alignment: FractionalOffset.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Text(
                    "Please click the button to view your all flashcard",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 18,
                        fontFamily: "Nunito"),
                  ),
                ),
              );
            }

            return GestureDetector(
              child: CardTile(
                  item: CardItem(
                cardName: '${listfcs[index].question}',
                subject: '${listfcs[index].answer}',
              )),
              onDoubleTap: () {
                Navigator.pushNamed(context, '/8');
              },
            );
          },
        );

//เลื่อนไปดู flashcard อันถัดไป
  void Next() {
    setState(() {
      if (_index + 1 >= listfcs.length) {
        progress = (_index + 1) / listfcs.length;
        End();
      } else {
        _index = _index + 1;
        number = number + 1;
        progress = (_index + 1) / listfcs.length;
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
        progress = (_index + 1) / listfcs.length;
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
    wdWidth = MediaQuery.of(context).size.width;
    wdheight = MediaQuery.of(context).size.height;
    //final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    _popupWidth = wdWidth - 30;
    _popupHeight = wdheight - 400;

    switch (_pageState) {
      case 0:
        _popupYOffset = wdheight;
        _popupXOffset = 15;

        break;

      case 1:
        _popupYOffset = 100;
        _popupXOffset = 15;

        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Listfcs'),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              if (_pageState != 0) {
                _pageState = 0;
              } else {
                _pageState = 1;
              }
            });
          },
          child: Icon(Icons.add),
        ),
      ),
      body: //Center(child: body),
          Stack(
        children: [
          Column(
            children: [
              /*SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    child: Text("Create a card"),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                      ),
                      primary: Colors.blue[400],
                      onPrimary: Colors.white,
                      elevation: 0,
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito",
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_pageState != 0) {
                          _pageState = 0;
                        } else {
                          _pageState = 1;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ]),*/
              AnimatedContainer(
                padding: EdgeInsets.all(32),
                width: _popupWidth,
                height: _popupHeight,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(
                  milliseconds: 1000,
                ),
                transform:
                    Matrix4.translationValues(_popupXOffset, _popupYOffset, 1),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'A Card',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _formkey3,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  hintText: "Question...",
                                  icon: Icon(Icons.help),
                                  labelText: "Enter your Question",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your question";
                                  }
                                },
                                onSaved: (question) {
                                  //context.read<FormModel>().Questions.add(value!);
                                  fcqanda.question = question;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  hintText: "Answer...",
                                  icon: Icon(Icons.task_alt),
                                  labelText: "Enter your answer",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your answer';
                                  }
                                },
                                onSaved: (answer) {
                                  /*context.read<FormModel>().Answers.add(value!);*/
                                  fcqanda.answer = answer;
                                },
                              ),
                              SizedBox(height: 30),
                              //if (!isKeyboard)
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  child: Text("Create "),
                                  style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(40.0),
                                    ),
                                    primary: Color(0xFF38b6ff),
                                    onPrimary: Colors.white,
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formkey3.currentState!.validate()) {
                                      _formkey3.currentState!.save();
                                      await _fcqandaCollection.add({
                                        "Question": fcqanda.question,
                                        "Answer": fcqanda.answer
                                      });
                                      _formkey3.currentState!.reset();
                                      setState(() {
                                        _pageState = 0;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getListfcs,
        child: Icon(Icons.add),
      ),
    );
  }
}
//.play_arrow

class Formqa {
  String? question;
  String? answer;

  Formqa({this.question, this.answer});
}
