import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/constants/contants.dart';
import 'package:nike_store/widget/custombutton.dart';
import 'package:nike_store/widget/custominput.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  // create a new user account
  Future<String> _createNewUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
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
      _registerformloading = true;
    });
    // show errors with alertdailog and submiting the form
    String _createAccountFeedBack = await _createNewUser();
    if (_createAccountFeedBack != null) {
      alertDailogBuilder(_createAccountFeedBack);
      // get the loader off
      setState(() {
        _registerformloading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // default form loading state
  bool _registerformloading = false;
  // form input field values
  String _registerEmail = '';
  String _registerPassword = '';

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
                  'Create A New Account',
                  textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hinttext: 'Email...',
                    onchanged: (value) {
                      _registerEmail = value;
                    },
                    onsubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hinttext: 'Password...',
                    onchanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    onsubmitted: (value) {
                      _submitform();
                    },
                    obscuretext: true,
                  ),
                  CustomButton(
                    onpressed: () {
                      _submitform();
                    },
                    text: 'Create New Account',
                    isloading: _registerformloading,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CustomButton(
                  onpressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Back to Login',
                  outlinedbutton: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
