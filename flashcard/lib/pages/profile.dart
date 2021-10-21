import 'dart:io';
import 'package:flashcard/model/form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profilebox.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _message = 'Wanwaree';
  String? _lastName = 'Sithu';
  String? _email = 'wanwaree@hotmail.com';
  String? _password = '0123456';

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
                    GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: Image.asset(
                          'assets/pic.jpg',
                          width: 150,
                        ),
                      ),
                    ),
                  ],
                )),
            GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Consumer<FormModel>(
                    builder: (context, model, child) {
                      return ProfileBox("First Name", "${model.Username}");
                    },
                  ),
                ),
                onTap: () async {
                  Navigator.pushNamed(context, '/3');
                }),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                child: ProfileBox("Last Name", "$_lastName"),
                onTap: () async {
                  var response = await Navigator.pushNamed(context, '/3');
                  setState(() {
                    _lastName = response.toString();
                  });
                }),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                child: ProfileBox("Email", "$_email"),
                onTap: () async {
                  var response = await Navigator.pushNamed(context, '/4');
                  setState(() {
                    _email = response.toString();
                  });
                }),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                child: ProfileBox("Password", ""),
                onTap: () async {
                  var response = await Navigator.pushNamed(context, '/4');
                  setState(() {
                    _password = response.toString();
                  });
                }),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
