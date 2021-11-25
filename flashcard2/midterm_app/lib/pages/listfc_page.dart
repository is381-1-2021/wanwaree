import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_app/controllers/listfc_controller.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:midterm_app/pages/flashcardqa_model.dart';
//import 'package:midterm_app/model/formModel.dart';
//import 'package:midterm_app/pages/6flashcard.dart';
import 'package:midterm_app/pages/listfc_model.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/services/flashcardqa_services.dart';
//import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
//import 'package:midterm_app/pages/9flashbox.dart';

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

  double wdWidth = 0;
  double wdheight = 0;

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
                    "Please click the button to view all flashcard",
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
                // var con = '${listfcs[index].question}';
                // return cardID.con;

                Navigator.pushNamed(context, '/8');
              },
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Listfcs'),
      ),
      body: Center(child: body),
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
                    /*Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                      ],
                    ),*/
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

/*myAconfirmation(BuildContext context, {required String title, required String content, required VoidCallback ok}) async {
  showDialog(
    context: context, 
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text("Are you sure to delete this flashcard?"),
        actions: [
          FlatButton(
            onPressed: ok,
            child: Text("confirm"),
            ),
            FlatButton(
            onPressed: () async{
              Navigator.of(context).pop();
            },
            child: Text("cancel"),
            ),
        ],
      );
    });
}*/

/*deletefcCard(Fccard fccard, Function fccardDeleted) async {
  await FirebaseFirestore.instance
      .collection('fc_flashcardqa')
      .doc(Flashcardqa.question)
      .delete();
}*/

