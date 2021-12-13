import 'package:firebase_core/firebase_core.dart';
import 'package:midterm_app/model/form_model.dart';
import 'package:midterm_app/pages/cal.dart';
import 'package:midterm_app/pages/form.dart';
import 'package:midterm_app/pages/formemail.dart';
import 'package:midterm_app/pages/blank_page.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/history.dart';
import 'package:midterm_app/pages/history_page.dart';
import 'package:provider/provider.dart';
import 'pages/flash_card.dart';
import 'pages/profile.dart';
//import 'pages/pages_name.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue.shade100,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black87),
        ),
      ),
      initialRoute: '/8',
      routes: <String, WidgetBuilder>{
        /*'/1': (context) => Profile(),
        '/2': (context) => FlashCard(),
        '/3': (context) => EditProfile(),
        '/4': (context) => EditEmail(),
        '/5': (context) => All(),
        '/6': (context) => BlankPage(),*/
        '/8': (context) => CalPage(),
        '/9': (context) => HistoryPage(),
        '/10': (context) => MemoryPage(),
      },
    );
  }
}

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            MenuButton(caption: 'Profile', icontype: Icons.person, goto: '/1'),
            MenuButton(
                caption: 'My Flashcards',
                icontype: Icons.credit_card,
                goto: '/2'),
            MenuButton(
                caption: 'Edit Username', icontype: Icons.edit, goto: '/3'),
            MenuButton(
                caption: 'Edit E-mail', icontype: Icons.edit, goto: '/4'),
            MenuButton(caption: 'Main Menu', icontype: Icons.menu, goto: '/5'),
            MenuButton(
                caption: 'Bank Page',
                icontype: Icons.add_box_rounded,
                goto: '/6'),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({this.caption, this.icontype, this.goto});

  final String? caption;
  final IconData? icontype;
  final String? goto;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, goto!);
        },
        splashColor: Colors.lightBlue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icontype,
                size: 60.0,
                color: Colors.lightBlue[300],
              ),
              Text(caption!,
                  style: TextStyle(fontSize: 18.0, color: Colors.lightBlue))
            ],
          ),
        ),
      ),
    );
  }
}
