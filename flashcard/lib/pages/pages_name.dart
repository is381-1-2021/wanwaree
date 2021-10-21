import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blank Page'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_empty,
                color: Theme.of(context).accentColor,
              ),
              Expanded(
                  child: Text(
                'Blank Page',
                style: TextStyle(color: Colors.lightBlue),
                textAlign: TextAlign.center,
              ))
            ],
          ),
        ));
  }
}
