import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/6flashcard.dart';
import 'package:midterm_app/pages/9flash_card.dart';
import 'package:midterm_app/pages/addq&a.dart';

class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cards'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add),
              ),
              /*Tab(
                icon: Icon(Icons.list_alt),
              ),*/
              Tab(
                icon: Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            //ListfcPage(),
            FlashCardPage(),
          ],
        ),
      ),
    );
  }
}
