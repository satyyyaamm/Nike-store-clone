import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/constants/contants.dart';
import 'package:nike_store/screens/cartpage.dart';
import 'package:nike_store/services/firebaseServices.dart';

// ignore: must_be_immutable
class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackGround;

  CustomActionBar(
      {Key key,
      this.title,
      this.hasBackArrow,
      this.hasTitle,
      this.hasBackGround})
      : super(key: key);

  final CollectionReference _userreference =
      FirebaseFirestore.instance.collection('Users');

  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackGround = hasBackGround ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackGround
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 42,
        left: 24,
        right: 24,
        bottom: 54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/back_arrow.png',
                  width: 12,
                  height: 12,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action bar',
              style: Constants.boldheading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: StreamBuilder(
                stream: _userreference
                    .doc(_firebaseServices.getUserId())
                    .collection('cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  int _totalItem = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data.docs;
                    _totalItem = _documents.length;
                  }
                  return Text(
                    '$_totalItem' ?? '0',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
