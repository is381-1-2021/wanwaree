import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:midterm_app/model/formModel.dart';

class EditLastName extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Last Name'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    //hintText: "Please enter here",
                    labelText: "Last Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter here.';
                    }
                  },
                  onSaved: (value) {
                    _data = value!;
                  },
                  initialValue: context.read<FormModel>().lastName,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        context.read<FormModel>().lastName = _data;

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
