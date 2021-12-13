import 'package:flutter/material.dart';

class ThisButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;
  const ThisButton({
    Key? key,
    required this.text,
    required this.fillColor,
    this.textSize = 25,
    this.textColor = 0xffffffff,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: SizedBox(
        width: 90,
        height: 65,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          onPressed: () {
            callback(text);
          },
          color: fillColor != null ? Color(fillColor) : null,
          textColor: Color(textColor),
        ),
      ),
    );
  }
}
