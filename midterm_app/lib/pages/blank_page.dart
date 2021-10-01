import 'package:flutter/material.dart';

//หน้าว่าง
class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Page'),
      ),
      body: Center(
        child: (Icon(
          Icons.hourglass_empty_outlined,
          size: 60.0,
          color: Theme.of(context).accentColor,
        )),
      ),
    );
  }
}
