//หน้าเรียก หมวดหมู่ของ flashcard ออกมาดู
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_app/controllers/stackofcard_controller.dart';
import 'package:flutter/material.dart';
//import 'package:midterm_app/pages/6flashcard.dart';
import 'package:midterm_app/pages/createflashcard.dart';
import 'package:midterm_app/pages/stackofcard_model.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';
import 'package:flutter/cupertino.dart';

class StackofcardPage extends StatefulWidget {
  @override
  _StackofcardPageState createState() => _StackofcardPageState();
}

class _StackofcardPageState extends State<StackofcardPage> {
  List<Stackofcard> stackofcards = List.empty();
  bool isLoading = false;
  var services = FirebaseServices();
  var controller;

  final _formkey3 = GlobalKey<FormState>();
  Formqa fcqanda = Formqa();
  CollectionReference _stackofcardCollection =
      FirebaseFirestore.instance.collection("fc_cards");

  void initState() {
    super.initState();
    controller = StackofcardController(services);

    controller.onSync.listen(
      (bool syncState) => setState(() => isLoading = syncState),
    );
  }

  void _getStackofcards() async {
    var newStackofcards = await controller.fetchStackofcards();

    setState(() => stackofcards = newStackofcards);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: stackofcards.isEmpty ? 1 : stackofcards.length,
          itemBuilder: (ctx, index) {
            if (stackofcards.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 300.0,
                        left: 25.0,
                      ),
                    ),
                    Text(
                      "Please click the button to view your cards",
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 18,
                          fontFamily: "Nunito"),
                    ),
                  ],
                ),
              );
            }

            return GestureDetector(
              child: CardTile(
                  item: CardItem(
                cardName: '${stackofcards[index].name}',
                subject: '${stackofcards[index].subject}',
              )),
              onDoubleTap: () {
                Navigator.pushNamed(context, '/8');
              },
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Stackofcards'),
      ),
      body: Center(child: body),
      floatingActionButton: FloatingActionButton(
        onPressed: _getStackofcards,
        child: Icon(Icons.note_rounded),
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
            builder: (context) => CreateCardPage(name: item.cardName),
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

/*class DisplayStackofcards extends StatefulWidget {
  @override
  _DisplayStackofcardsState createState() => _DisplayStackofcardsState();
}

class _DisplayStackofcardsState extends State<DisplayStackofcards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('fc_cards').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document["subject"]),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}*/
