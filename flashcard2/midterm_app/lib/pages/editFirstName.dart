import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/model/formModel.dart';
import 'package:provider/provider.dart';

class EditFirstName extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit First Name'),
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
                    labelText: "First Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter here.';
                    }
                  },
                  onSaved: (value) {
                    _data = value!;
                  },
                  initialValue: context.read<FormModel>().firstName,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        context.read<FormModel>().firstName = _data;

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
