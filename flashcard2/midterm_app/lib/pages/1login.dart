import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:midterm_app/model/formModel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _pageState = 0;

  var _bgColor = Colors.white;
  var _fontColor = Color(0xFF38b6ff);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;

  double _signupHeight = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;

  double _loginOpacity = 1;

  double _signupYOffset = 0;

  double wdWidth = 0;
  double wdheight = 0;

  bool _keyboardVisible = false;

  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  String? _email = '';
  String? _firstName = '';
  String? _lastName = '';
  String? _password = '';
  String? _emailLogin = '';
  String? _passwordLogin = '';

  bool? _passwordVisible;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardVisible = visible;
      });
    });
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    wdWidth = MediaQuery.of(context).size.width;
    wdheight = MediaQuery.of(context).size.height;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    _loginHeight = wdheight - 270;
    _signupHeight = wdheight - 270;

    switch (_pageState) {
      case 0:
        _bgColor = Colors.white;
        _fontColor = Color(0xFF38b6ff);

        _headingTop = 100;

        _loginWidth = wdWidth;

        _loginYOffset = wdheight;
        _loginHeight = _keyboardVisible ? wdheight : wdheight - 270;
        _loginXOffset = 0;

        _loginOpacity = 1;

        _signupYOffset = wdheight;
        break;
      case 1:
        _bgColor = Color(0xFF38b6ff);
        _fontColor = Colors.white;

        _headingTop = 90;

        _loginWidth = wdWidth;

        _loginYOffset = _keyboardVisible ? 150 : 270;
        _loginHeight = _keyboardVisible ? wdheight - 150 : wdheight - 270;
        _loginXOffset = 0;

        _loginOpacity = 1;

        _signupYOffset = wdheight;
        break;
      case 2:
        _bgColor = Color(0xFF38b6ff);
        _fontColor = Colors.white;

        _headingTop = 80;

        _loginWidth = wdWidth - 40;

        _loginYOffset = _keyboardVisible ? 130 : 240;
        _loginHeight = _keyboardVisible ? wdheight - 130 : wdheight - 240;
        _loginXOffset = 20;

        _loginOpacity = 0.7;

        _signupYOffset = _keyboardVisible ? 160 : 270;
        _signupHeight = _keyboardVisible ? wdheight - 160 : wdheight - 270;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              milliseconds: 1000,
            ),
            color: _bgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 0;
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(
                            milliseconds: 1000,
                          ),
                          margin: EdgeInsets.only(
                            top: _headingTop,
                          ),
                          child: Text(
                            'Flash Card App',
                            style: TextStyle(
                              color: _fontColor,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'We want to make your learning more enjoyable and effective.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _fontColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Center(
                    child: Lottie.asset("assets/lottie/LoginImage.json"),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_pageState != 0) {
                          _pageState = 0;
                        } else {
                          _pageState = 1;
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(50),
                      padding: EdgeInsets.all(18),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFF38b6ff),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(32),
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              milliseconds: 1000,
            ),
            transform:
                Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(_loginOpacity),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Enter your Email...",
                              icon: Icon(Icons.email),
                              labelText: "Your Email",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Email';
                              }

                              if (value != _email) {
                                return '''Sorry, this email is invalid
Please sign up or enter a valid email''';
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            obscureText: !_passwordVisible!,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Enter your Password...",
                              icon: Icon(Icons.vpn_key),
                              labelText: "Your Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible!
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible!;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Password';
                              }

                              if (value != _password) {
                                return 'Please enter a valid Password';
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                child: Text(
                                  "Forget password",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 35),
                          if (!isKeyboard)
                            SizedBox(
                              height: 60,
                              width: 350,
                              child: ElevatedButton(
                                child: Text("Log in"),
                                style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(40.0),
                                  ),
                                  primary: Color(0xFF38b6ff),
                                  onPrimary: Colors.white,
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Nunito",
                                  ),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();

                                    Navigator.pushReplacementNamed(
                                        context, '/Home');
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    if (!isKeyboard)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Don't have an account yet?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          MaterialButton(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _pageState = 2;
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedContainer(
            height: _signupHeight,
            padding: EdgeInsets.all(32),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              milliseconds: 1000,
            ),
            transform: Matrix4.translationValues(0, _signupYOffset, 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: _formkey2,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Enter your Email...",
                              icon: Icon(Icons.email),
                              labelText: "Your Email",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Email';
                              }
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Enter your First Name...",
                              icon: Icon(Icons.person),
                              labelText: "Your First Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your First Name';
                              }
                            },
                            onSaved: (value) {
                              _firstName = value!;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Enter your Last Name...",
                              icon: Icon(Icons.family_restroom),
                              labelText: "Your Last Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Last Name';
                              }
                            },
                            onSaved: (value) {
                              _lastName = value!;
                            },
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            obscureText: !_passwordVisible!,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              hintText: "Enter your Password...",
                              icon: Icon(Icons.vpn_key),
                              labelText: "Your Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible!
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible!;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Your Password';
                              }
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          SizedBox(height: 35),
                          if (!isKeyboard)
                            SizedBox(
                              height: 55,
                              width: 350,
                              child: ElevatedButton(
                                child: Text("Create New Account"),
                                style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(40.0),
                                  ),
                                  primary: Color(0xFF38b6ff),
                                  onPrimary: Colors.white,
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Nunito",
                                  ),
                                ),
                                onPressed: () {
                                  if (_formkey2.currentState!.validate()) {
                                    _formkey2.currentState!.save();

                                    context.read<FormModel>().email = _email;
                                    context.read<FormModel>().firstName =
                                        _firstName;
                                    context.read<FormModel>().lastName =
                                        _lastName;
                                    context.read<FormModel>().password =
                                        _password;

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Sign up success! $_firstName $_lastName, back to login'),
                                    ));
                                    setState(() {
                                      _pageState = 1;
                                    });
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    if (!isKeyboard)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          MaterialButton(
                            child: Text(
                              "Back To Login",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _pageState = 1;
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
