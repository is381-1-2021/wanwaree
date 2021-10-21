import 'package:flashcard/model/form_model.dart';
import 'package:flashcard/pages/form.dart';
import 'package:flashcard/pages/formemail.dart';
import 'package:flashcard/pages/pages_name.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/flash_card.dart';
import 'pages/profile.dart';
//import 'pages/pages_name.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FormModel(),
        )
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
      initialRoute: '/5',
      routes: <String, WidgetBuilder>{
        '/1': (context) => Profile(),
        '/2': (context) => FlashCard(),
        '/3': (context) => EditProfile(),
        '/4': (context) => EditEmail(),
        '/5': (context) => All(),
        '/6': (context) => BlankPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
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
        title: Text('Profile & Flashcard'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            MenuButton(caption: 'Profile', icontype: Icons.person, goto: '/1'),
            MenuButton(
                caption: 'My Flashcards',
                icontype: Icons.campaign_rounded,
                goto: '/2'),
            MenuButton(
                caption: 'Edit Username', icontype: Icons.edit, goto: '/3'),
            MenuButton(
                caption: 'Edit E-mail', icontype: Icons.edit, goto: '/4'),
            MenuButton(caption: 'Main Menu', icontype: Icons.menu, goto: '/5'),
            MenuButton(
                caption: 'Bank Page',
                icontype: Icons.check_box_outline_blank,
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
                size: 75.0,
                color: Colors.lightBlue[200],
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
