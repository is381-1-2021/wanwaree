import 'package:midterm_app/controllers/history_controller.dart';
import 'package:midterm_app/pages/history.dart';
import 'package:midterm_app/pages/history_model.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/services/services.dart';

class MemoryPage extends StatefulWidget {
  //final HistoryController controller;

  //MemoryPage({required this.controller});

  @override
  _MemoryPageState createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  List<History> historys = List.empty();
  bool isLoading = false;
  var services = FirebaseServices();
  var controller;

  void initState() {
    super.initState();
    controller = HistoryController(services);

    controller.onSync.listen(
      (bool syncState) => setState(() => isLoading = syncState),
    );
  }

  void _getHistorys() async {
    var newHistorys = await controller.fetchHistorys();

    setState(() => historys = newHistorys);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: historys.isEmpty ? 1 : historys.length,
          itemBuilder: (ctx, index) {
            if (historys.isEmpty) {
              return Container(
                alignment: FractionalOffset.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Text(
                    "Tab the button to fetch history",
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }
            return Container(
              margin: EdgeInsets.fromLTRB(0, 10, 10, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    historys[index].process,
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  Text(
                    historys[index].result,
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
        );

  /*return Container(
              child: CardTile(
                  item: CardItem(
                process: '${historys[index].process}',
                result: '${historys[index].result}',
              )),
            );
          },
        );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(child: body),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: _getHistorys,
        child: Icon(
          Icons.rotate_right_sharp,
        ),
      ),
      backgroundColor: Colors.grey[600],
    );
  }
}
