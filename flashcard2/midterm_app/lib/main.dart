import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/model/formModel.dart';

import 'package:midterm_app/pages/1login.dart';
import 'package:midterm_app/pages/2home.dart';
import 'package:midterm_app/pages/2homeVer2.dart';
import 'package:midterm_app/pages/3profile.dart';
import 'package:midterm_app/pages/4fav.dart';
import 'package:midterm_app/pages/5search.dart';
import 'package:midterm_app/pages/6flashcard.dart';
import 'package:midterm_app/pages/7notification.dart';
import 'package:midterm_app/pages/8settings.dart';
import 'package:midterm_app/pages/9flash_card.dart';
import 'package:midterm_app/pages/createflashcard.dart';
import 'package:midterm_app/pages/createqa_in_sub.dart';
import 'package:midterm_app/pages/editEmail.dart';
import 'package:midterm_app/pages/editFirstName.dart';
import 'package:midterm_app/pages/editLastName.dart';
import 'package:midterm_app/pages/editPassword.dart';
import 'package:midterm_app/pages/flashcardqa_page.dart';
import 'package:midterm_app/pages/listfc_page.dart';
import 'package:midterm_app/pages/login.dart';
import 'package:midterm_app/pages/profile.dart';
import 'package:midterm_app/pages/stackofcard_page.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FormModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        context.read<FormModel>().islogin = false;
      } else {
        print('User is signed in!');
        context.read<FormModel>().islogin = true;
      }
    });
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Nunito",
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage3(),
      routes: {
        '/Login': (context) => LoginPage2(),
        '/Home': (context) => MyHomePage3(),
        '/Profile': (context) => ProfilePage(),
        '/Favorite': (context) => FavoritePage(),
        '/Search': (context) => SearchPage(),
        '/FlashCard': (context) => FlashCardPage(),
        '/Settings': (context) => SettingsPage(),
        '/Notification': (context) => NotificationPage(),
        '/3': (context) => EditFirstName(),
        '/4': (context) => EditLastName(),
        '/5': (context) => EditEmail(),
        '/6': (context) => EditPassword(),
        '/7': (context) => FlashCard(),
        '/8': (context) => FlashcardqaPage(),
        '/9': (context) => ListfcPage(),
        '/10': (context) => CreateCardPage(),
        '/11': (context) => StackofcardPage(),
        //'/12': (context) => CreateQAinSubPage(),
      },
    );
  }
}
