import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:provider/provider.dart';

class Navibar extends StatefulWidget {
  @override
  _NavibarState createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final profileImage = "assets/images/Min.png";

    return Drawer(
      child: Material(
        color: Colors.blue[400],
        child: ListView(
          children: <Widget>[
            headerSideBar(
              profileImage: profileImage,
              onClicked: () {
                Navigator.pushReplacementNamed(context, '/Profile');
              },
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  Divider(color: Colors.white),
                  SizedBox(height: 24),
                  menuSideBar(
                    text: "Home",
                    icon: Icons.home,
                    onClicked: () {
                      Navigator.pushReplacementNamed(context, '/Home');
                    },
                  ),
                  SizedBox(height: 16),
                  menuSideBar(
                    text: "Profile",
                    icon: Icons.person,
                    onClicked: () {
                      Navigator.pushReplacementNamed(context, '/Profile');
                    },
                  ),
                  SizedBox(height: 16),
                  menuSideBar(
                    text: "Favorites",
                    icon: Icons.favorite_border,
                    onClicked: () {
                      Navigator.pushReplacementNamed(context, '/Favorite');
                    },
                  ),
                  SizedBox(height: 16),
                  menuSideBar(
                    text: "Notifications",
                    icon: Icons.notifications_active_outlined,
                    onClicked: () {
                      Navigator.pushReplacementNamed(context, '/Notification');
                    },
                  ),
                  SizedBox(height: 24),
                  Divider(color: Colors.white),
                  SizedBox(height: 24),
                  menuSideBar(
                    text: "Settings",
                    icon: Icons.settings,
                    onClicked: () {
                      Navigator.pushReplacementNamed(context, '/Settings');
                    },
                  ),
                  SizedBox(height: 16),
                  menuSideBar(
                    text: "Log Out",
                    icon: Icons.exit_to_app,
                    onClicked: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/Login');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerSideBar({
    required String profileImage,
    VoidCallback? onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                child: ClipOval(
                  child: Image.asset(profileImage),
                ),
              ),
              SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FormModel>(
                    builder: (context, model, child) {
                      return Text(
                        auth.currentUser!.email == null
                            ? "not login"
                            : auth.currentUser!.email!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget menuSideBar({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 16,
        ),
      ),
      onTap: onClicked,
    );
  }
}
