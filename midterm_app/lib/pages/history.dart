import 'package:flutter/material.dart';
import 'package:midterm_app/model/form_model.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              icon: Icon(Icons.date_range_outlined),
              tooltip: 'Memory',
              onPressed: () {
                Navigator.pushNamed(context, '/10');
              })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Consumer<FormModel>(builder: (context, model, child) {
              return Expanded(
                child: model.Process.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        itemCount: model.Process.length,
                        itemBuilder: (context, index) {
                          return CardTile(
                            item: CardItem(
                              process: model.Process[index],
                              result: model.Result[index],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "No Record",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
              );
            }),
            Icon(
              Icons.delete_outline,
              size: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade600,
    );
  }
}

class CardItem {
  final String process;
  final String result;

  const CardItem({
    Key? key,
    required this.process,
    required this.result,
  });
}

class CardTile extends StatelessWidget {
  final CardItem item;
  const CardTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),

          /*boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.6),
              blurRadius: 4,
              offset: Offset(4, 8),
            ),
          ],*/
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "${item.process} ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${item.result}',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
