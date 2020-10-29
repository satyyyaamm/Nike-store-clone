import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/screens/homepage.dart';
import 'package:nike_store/screens/loginpage.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //  if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('error: ${snapshot.error}'),
            ),
          );
        }
        // connection initialization - firebase app is running properly
        if (snapshot.connectionState == ConnectionState.done) {
          // steam builder will basically check the authentication live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              // if streamsnapshot has error
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('error: ${streamsnapshot.error}'),
                  ),
                );
              }
              // connection state active - do the user login check inside
              // the if statement

              if (streamsnapshot.connectionState == ConnectionState.active) {
                //  get the user
                User _user = streamsnapshot.data;
                // if the user is null we're not logged in
                if (_user == null) {
                  // user not logged in
                  return LoginPage();
                } else {
                  // user logged in
                  return HomePage();
                }
              }
              // checking the authentication state - loading
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }

        // conntecting to firebase - loading
        return Scaffold(
          body: Center(
            child: Text('intializing '),
          ),
        );
      },
    );
  }
}
