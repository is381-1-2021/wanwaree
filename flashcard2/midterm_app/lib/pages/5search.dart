import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey[600],
                          )),
                    ),
                  ),
                ]),
          ),
          bottom: TabBar(
            controller: controller,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'All Result'),
              Tab(text: 'Flashcard'),
              Tab(text: 'Folder'),
              Tab(text: 'Users'),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            HomePage(),
            HomePage(),
            HomePage(),
            HomePage(),
          ],
        ));
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
