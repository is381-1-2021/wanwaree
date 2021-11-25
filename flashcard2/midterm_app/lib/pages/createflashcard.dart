import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/0NaviBar.dart';

class CreateCardPage extends StatelessWidget {
  String? name;
  CreateCardPage({Key? key, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navibar(),
      appBar: AppBar(
        title: Text('My Flashcard'),
        centerTitle: true,
      ),
      body: CreateNewfc(),
    );
  }
}

class CreateNewfc extends StatefulWidget {
  const CreateNewfc({Key? key}) : super(key: key);

  @override
  _CreateNewfcState createState() => _CreateNewfcState();
}

class _CreateNewfcState extends State<CreateNewfc> {
  int _pageState = 0;

  double _popupWidth = 0;
  double _popupHeight = 0;

  double _popupYOffset = 0;
  double _popupXOffset = 0;

  double wdWidth = 0;
  double wdheight = 0;

  final _formkey3 = GlobalKey<FormState>();
  Formqa fcqanda = Formqa();
  CollectionReference _fcqandaCollection = FirebaseFirestore.instance
      .collection("fc_subcards")
      .doc('Zzei3LvulpsixJC3Lh19')
      .collection("fc_flashcard");

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
    return Stack(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(30),
          //width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/cards_bg.png"),
            ),
          ),
        ),
      ),
      Column(
        children: [
          /*SizedBox(
            child: Container(
              height: 350,
              width: 300,
              padding: EdgeInsets.all(30),
              //width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/cards_bg.png"),
                ),
              ),
            ),
          ),*/
          SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ]),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 60,
            width: 300,
            child: ElevatedButton(
                child: Text("View Flashcard"),
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
                  Navigator.pushNamed(context, '/9');
                }),
          ),
        ],
      ),
      AnimatedContainer(
        padding: EdgeInsets.all(32),
        width: _popupWidth,
        height: _popupHeight,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(
          milliseconds: 1000,
        ),
        transform: Matrix4.translationValues(_popupXOffset, _popupYOffset, 1),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                              borderRadius: new BorderRadius.circular(40.0),
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
                                "question": fcqanda.question,
                                "answer": fcqanda.answer
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
    ]);
  }
}

class Formqa {
  String? question;
  String? answer;

  Formqa({this.question, this.answer});
}
