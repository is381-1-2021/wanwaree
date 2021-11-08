import 'package:flutter/material.dart';
import 'package:midterm_app/pages/0NaviBar.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navibar(),
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Blank Page"),
          ],
        ),
      ),
    );
  }
}
