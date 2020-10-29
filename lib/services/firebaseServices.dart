import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }

  final CollectionReference productreference =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference userreference =
      FirebaseFirestore.instance.collection('Users');
}
