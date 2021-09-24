import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  String title;
  String data;

  ProfileBox(this.title, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: Colors.white),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              data,
              style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              textAlign: TextAlign.right,
            ),
          ),
          Tab(
              icon: Icon(
            Icons.chevron_right,
            color: Colors.blueAccent,
          ))
        ],
      ),
    );
  }
}
