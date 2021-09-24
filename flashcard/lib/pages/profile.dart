import 'package:flutter/material.dart';
import 'profilebox.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                ),
                height: 230,
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200.0),
                      child: Image.asset(
                        'assets/pic.jpg',
                        width: 150,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Choose Picture",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
            ProfileBox("Username", "Wanwaree Sinthu"),
            SizedBox(
              height: 5,
            ),
            ProfileBox("Email", "wanwaree@hotmail.com"),
            SizedBox(
              height: 5,
            ),
            ProfileBox("About", ""),
            SizedBox(
              height: 5,
            ),
            ProfileBox("Setting", ""),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
