import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.fingerprint),
            tooltip: 'Button 1',
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bungalow),
            tooltip: 'button 2',
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('First Page'),
      ),
    );
  }
}
