import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:midterm_app/model/formModel.dart';

class FlashCardPage extends StatelessWidget {
  String? name;
  FlashCardPage({Key? key, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
        centerTitle: true,
      ),
      body: CreateFlashCard(),
    );
  }
}

class CreateFlashCard extends StatefulWidget {
  @override
  _CreateFlashCardState createState() => _CreateFlashCardState();
}

class _CreateFlashCardState extends State<CreateFlashCard> {
  int _pageState = 0;

  double _popupWidth = 0;
  double _popupHeight = 0;

  double _popupYOffset = 0;
  double _popupXOffset = 0;

  double wdWidth = 0;
  double wdheight = 0;

  final _formkey3 = GlobalKey<FormState>();

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 30),
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
                      Consumer<FormModel>(builder: (context, model, child) {
                        return Expanded(
                          child: model.Questions.length > 0
                              ? ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  itemCount: model.Questions.length,
                                  itemBuilder: (context, index) {
                                    return CardTile(
                                      item: CardItem(
                                        cardName: model.Questions[index],
                                        subject: model.Answers[index],
                                      ),
                                    );
                                  },
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
                            onSaved: (value) {
                              context.read<FormModel>().Questions.add(value!);
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
                            onSaved: (value) {
                              context.read<FormModel>().Answers.add(value!);
                            },
                          ),
                          SizedBox(height: 30),
                          if (!isKeyboard)
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
                                onPressed: () {
                                  if (_formkey3.currentState!.validate()) {
                                    _formkey3.currentState!.save();

                                    setState(() {
                                      _pageState = 0;
                                    });
                                  }
                                },
                              ),
                            ),
                          SizedBox(height: 25),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/7');
        },
        tooltip: 'Play',
        child: Icon(Icons.play_arrow_rounded),
      ),
    );
  }
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
      onTap: () {},
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
                    margin: EdgeInsets.only(top: 3, left: 10),
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
                padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "Q: ${item.cardName}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[900],
                      ),
                    ),
                    Text(
                      'A : ${item.subject}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red[800]),
                    ),
                    Icon(Icons.favorite)
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
