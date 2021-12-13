import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:midterm_app/model/form_model.dart';
import 'package:midterm_app/pages/thisbutton.dart';

class CalPage extends StatelessWidget {
  const CalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('standard'),
        backgroundColor: Colors.grey.shade900,
      ),
      drawer: Container(
        child: Drawer(
          child: Container(
            color: Colors.black,
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/9');
                  },
                  splashColor: Color(0xFFE2AA31),
                  child: ListTile(
                    title: Text(
                      "History",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/10');
                  },
                  splashColor: Color(0xFFE2AA31),
                  child: ListTile(
                    title: Text(
                      "Memory",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      body: CalculatorPro(),
    );
  }
}

class CalculatorPro extends StatefulWidget {
  const CalculatorPro({Key? key}) : super(key: key);

  @override
  _CalculatorProState createState() => _CalculatorProState();
}

class _CalculatorProState extends State<CalculatorPro> {
  final _formKey = GlobalKey<FormState>();
  String _process = '';
  String _result = '';

  final _formkey3 = GlobalKey<FormState>();
  Formqa historylist = Formqa();
  CollectionReference _historyCollection =
      FirebaseFirestore.instance.collection("waree_memory");
  void clickNumButton(String text) {
    setState(() {
      _result += text;
      _result = _result.replaceAll('1⁄𝘹', '1/');
      _result = _result.replaceAll('𝘹²', '^(2)');
    });
  }

  void sqrRootButton(String text) {
    setState(() {
      _result += text;
      _result = _result.replaceAll('√', '(^0.5)');
      /*if (_result != '') {
        _result = _result + '*√';
      }*/
    });
  }

  void clickCButton(String text) {
    setState(() {
      _process = '';
      _result = '';
    });
  }

  void clickICONButton(String text) {
    setState(() {
      _result = _result.substring(0, _result.length - 1);
      _process = '';
      if (_result == "0") {
        _result = "0";
      }
    });
  }

  void manipulate(String text) {
    _result = _result.replaceAll('×', '*');
    _result = _result.replaceAll('÷', '/');
    _result = _result.replaceAll('1⁄𝘹', '1/');
    _result = _result.replaceAll('√', '(^0.5)');
    _result = _result.replaceAll('𝘹²', '^(2)');
    Parser p = new Parser();
    Expression exp = p.parse(_result);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      _process = _result + '=';
      _process = _process.replaceAll('*', '×');
      _process = _process.replaceAll('/', '÷');
      _result = eval.toString();
      //context.read<FormModel>().Result = _result;
      //context.read<FormModel>().Process = _process;
      context.read<FormModel>().Result.add(_result);
      context.read<FormModel>().Process.add(_process);
      historylist.process = _process;
      historylist.result = _result;
      _historyCollection
          .add({"process": historylist.process, "result": historylist.result});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              _process,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            alignment: Alignment(1, 1),
          ),
          SizedBox(
            height: 15,
          ),
          /*TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter lastname.';
              }
            },
            onSaved: (value) {
              _result = value!;
            },
            initialValue: context.read<FormModel>().result,
          ),*/
          Container(
            padding: EdgeInsets.only(right: 9.0),
            child: Text(
              _result,
              style: TextStyle(fontSize: 65, color: Colors.white),
            ),
            alignment: Alignment(1, 1),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'MC',
                  style: TextStyle(fontSize: 20, color: Colors.white10),
                ),
                Text(
                  'MR',
                  style: TextStyle(fontSize: 20, color: Colors.white10),
                ),
                Text(
                  'M+',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'M-',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'MS',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ThisButton(
                text: '%',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
              ThisButton(
                text: 'CE',
                fillColor: 0xff6B6963,
                callback: clickCButton,
              ),
              ThisButton(
                text: 'C',
                fillColor: 0xff6B6963,
                callback: clickCButton,
              ),
              ThisButton(
                text: '⌫',
                fillColor: 0xff6B6963,
                callback: clickICONButton,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ThisButton(
                text: '1⁄𝘹',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '𝘹²',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '√',
                fillColor: 0xff6B6963,
                callback: sqrRootButton,
              ),
              ThisButton(
                text: '÷',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ThisButton(
                text: '7',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '8',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '9',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '×',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ThisButton(
                text: '4',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '5',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '6',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '-',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ThisButton(
                text: '1',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '2',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '3',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '+',
                fillColor: 0xff6B6963,
                callback: clickNumButton,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ThisButton(
                text: '⁺⁄˗',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '0',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              ThisButton(
                text: '.',
                fillColor: 0xff000000,
                callback: clickNumButton,
              ),
              GestureDetector(
                  child: ThisButton(
                    text: '=',
                    fillColor: 0xffFEC13E,
                    callback: manipulate,
                  ),
                  onTap: () async {
                    if (_process != '' && _result != '') {
                      await _historyCollection.add({
                        "process": historylist.process,
                        "result": historylist.result
                      });
                      _formkey3.currentState!.reset();
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class Formqa {
  String? process;
  String? result;

  Formqa({this.process, this.result});
}
