import 'package:flutter/material.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:midterm_app/pages/0NaviBar.dart';
import 'package:midterm_app/pages/3profliebox.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navibar(),
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
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
                    CircleAvatar(
                      radius: 80,
                      child: ClipOval(
                        child: Image.asset("assets/images/Min.png"),
                      ),
                    ),
                  ],
                )),
            Consumer<FormModel>(
              builder: (context, model, child) {
                return GestureDetector(
                  child: ProfileBox(
                    "First Name",
                    "${model.firstName}",
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/3');
                    setState(() {
                      model.firstName = model.firstName;
                    });
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<FormModel>(
              builder: (context, model, child) {
                return GestureDetector(
                  child: ProfileBox(
                    "Last Name",
                    "${model.lastName}",
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/4');
                    setState(() {
                      model.lastName = model.lastName;
                    });
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<FormModel>(
              builder: (context, model, child) {
                return GestureDetector(
                  child: ProfileBox(
                    "Email",
                    "${model.email}",
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/5');
                    setState(() {
                      model.email = model.email;
                    });
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<FormModel>(
              builder: (context, model, child) {
                return GestureDetector(
                  child: ProfileBox(
                    "Password",
                    " ",
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/6');
                    setState(() {
                      model.password = model.password;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
