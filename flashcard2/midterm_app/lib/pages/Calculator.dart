import 'package:flutter/material.dart';
//import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 25.0;
  double resultFontSize = 35.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        double equationFontSize = 25.0;
        double resultFontSize = 35.0;
      }
    });
  }

  Widget myButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.black54,
              width: 1,
              style: BorderStyle.solid,
            )),
        padding: EdgeInsets.all(15.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget iconinButton(String buttonText, IconData icon, double buttonHeight,
      Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.black54,
              width: 1,
              style: BorderStyle.solid,
            )),
        //padding: EdgeInsets.all(15.0),
        onPressed: () => buttonPressed(buttonText),
        child: Icon(
          icon,
          size: 25.0,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Standard'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      myButton("%", 1, Colors.blueAccent),
                      myButton("CE", 1, Colors.blue.shade200),
                      myButton("C", 1, Colors.blue.shade100),
                    ]),
                    TableRow(children: [
                      myButton("1⁄𝘹", 1, Colors.blueGrey.shade700),
                      myButton("𝘹²", 1, Colors.blueGrey.shade700),
                      myButton("²√𝘹", 1, Colors.blueGrey.shade700),
                    ]),
                    TableRow(children: [
                      myButton("7", 1, Colors.blueGrey.shade900),
                      myButton("8", 1, Colors.blueGrey.shade900),
                      myButton("9", 1, Colors.blueGrey.shade900),
                    ]),
                    TableRow(children: [
                      myButton("4", 1, Colors.blueGrey.shade900),
                      myButton("5", 1, Colors.blueGrey.shade900),
                      myButton("6", 1, Colors.blueGrey.shade900),
                    ]),
                    TableRow(children: [
                      myButton("1", 1, Colors.blueGrey.shade900),
                      myButton("2", 1, Colors.blueGrey.shade900),
                      myButton("3", 1, Colors.blueGrey.shade900),
                    ]),
                    TableRow(children: [
                      myButton("⁺⁄˗", 1, Colors.blueGrey.shade900),
                      myButton("0", 1, Colors.blueGrey.shade900),
                      myButton(".", 1, Colors.blueGrey.shade900),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      iconinButton("", Icons.backspace_outlined, 1,
                          Colors.blueGrey.shade700),
                    ]),
                    TableRow(children: [
                      myButton("÷", 1, Colors.blueGrey.shade700),
                    ]),
                    TableRow(children: [
                      myButton("×", 1, Colors.blueGrey.shade700),
                    ]),
                    TableRow(children: [
                      myButton("-", 1, Colors.blueGrey.shade700),
                    ]),
                    TableRow(children: [
                      myButton("+", 1, Colors.blueGrey.shade700),
                    ]),
                    TableRow(children: [
                      myButton("=", 1, Colors.lightBlue.shade800),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
