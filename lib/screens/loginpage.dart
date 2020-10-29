import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/constants/contants.dart';
import 'package:nike_store/screens/registerpage.dart';
import 'package:nike_store/widget/custombutton.dart';
import 'package:nike_store/widget/custominput.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // build and alert dialog to display some errors
  Future<void> alertDailogBuilder(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('close'),
              )
            ],
          );
        });
  }

  //signing in the user
  Future<String> _signInUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitform() async {
    // set the loader working while the backend is doing its job
    setState(() {
      _loginformloading = true;
    });
    // show errors with alertdailog and submiting the form
    String _createAccountFeedBack = await _signInUser();
    if (_createAccountFeedBack != null) {
      alertDailogBuilder(_createAccountFeedBack);
      // get the loader off
      setState(() {
        _loginformloading = false;
      });
    }
  }

  // default form loading state
  bool _loginformloading = false;

  // form input field values
  String _loginEmail = '';
  String _loginPassword = '';

  // Focusnode for the inputfields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 24.0),
              child: Text(
                'Welcome,\n Login to your account',
                textAlign: TextAlign.center,
                style: Constants.boldheading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hinttext: 'Email...',
                  textInputAction: TextInputAction.next,
                  onchanged: (value) {
                    _loginEmail = value;
                  },
                  onsubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                ),
                CustomInput(
                  hinttext: 'Password...',
                  onchanged: (value) {
                    _loginPassword = value;
                  },
                  onsubmitted: (value) {
                    _submitform();
                  },
                  obscuretext: true,
                ),
                CustomButton(
                  onpressed: () {
                    _submitform();
                  },
                  text: 'Login',
                  isloading: _loginformloading,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: CustomButton(
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                text: 'Create New Account',
                outlinedbutton: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
