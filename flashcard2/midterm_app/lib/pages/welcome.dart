import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:midterm_app/pages/0NaviBar.dart';
import 'package:provider/provider.dart';

import '6flashcard.dart';

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  int _pageState = 0;

  double _popupWidth = 0;
  double _popupHeight = 0;

  double _popupYOffset = 0;
  double _popupXOffset = 0;

  double wdWidth = 0;
  double wdheight = 0;

  final _formkey3 = GlobalKey<FormState>();
  Formcard stackofcard = Formcard();
  CollectionReference _stackofcardCollection =
      FirebaseFirestore.instance.collection("fc_cards");
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    wdWidth = MediaQuery.of(context).size.width;
    wdheight = MediaQuery.of(context).size.height;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
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
      backgroundColor: Colors.blue[300],
      drawer: Navibar(),
      appBar: AppBar(
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 25),
            onPressed: () {
              Navigator.pushNamed(context, '/Search');
            },
            icon: Icon(Icons.search),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_bg.png"),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Consumer<FormModel>(
                        builder: (context, model, child) {
                          return Text(
                            auth.currentUser!.email!,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: ElevatedButton(
                              child: Text("Create your Flash Card"),
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0),
                                ),
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                onSurface: Colors.blue,
                                elevation: 20,
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
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/cards_bg.png"),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Your Flash Cards ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Consumer<FormModel>(builder: (context, model, child) {
                        return Expanded(
                          child: model.cardName.length > 0
                              ? ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  itemCount: model.cardName.length,
                                  itemBuilder: (context, index) {
                                    return CardTile(
                                      item: CardItem(
                                        cardName: model.cardName[index],
                                        subject: model.subject[index],
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text(
                                    "No Flash Card",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                        );
                      }),
                    ],
                  ),
                ),
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
                        'Create your Flash Card',
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
                              hintText: "Flash Card...",
                              icon: Icon(Icons.assignment),
                              labelText: "Name your flash card",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please name your flash card";
                              }
                            },
                            onSaved: (name) {
                              stackofcard.name = name;
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Subject...",
                              icon: Icon(Icons.work),
                              labelText: "Enter the subject",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the subject';
                              }
                            },
                            onSaved: (subject) {
                              //context.read<FormModel>().subject.add(value!);
                              stackofcard.subject = subject;
                            },
                          ),
                          SizedBox(height: 20),
                          if (!isKeyboard)
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                child: Text("Create Flash Card"),
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
                                    await _stackofcardCollection.add({
                                      "name": stackofcard.name,
                                      "subject": stackofcard.subject
                                    });
                                    _formkey3.currentState!.reset();
                                    setState(() {
                                      _pageState = 0;
                                    });
                                  }
                                },
                              ),
                            ),
                          SizedBox(height: 15),
                          if (!isKeyboard)
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                child: Text("Cancel"),
                                style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(40.0),
                                  ),
                                  primary: Colors.red,
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
                                    _pageState = 0;
                                  });
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
    );
  }
}

class Formcard {
  String? name;
  String? subject;

  Formcard({this.name, this.subject});
}

class CardItem {
  final String cardName;
  final String subject;

  const CardItem({
    Key? key,
    required this.cardName,
    required this.subject,
  });
}

class CardTile extends StatelessWidget {
  final CardItem item;
  const CardTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlashCardPage(name: item.cardName),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.blue[200],
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.6),
              blurRadius: 4,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 3, left: 20),
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/cards.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      item.cardName,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Subject : ${item.subject}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[900]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("welcome"),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Text(
    //             auth.currentUser!.email!,
    //             style: TextStyle(fontSize: 25),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );