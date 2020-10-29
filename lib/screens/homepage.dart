import 'package:flutter/material.dart';
import 'package:nike_store/services/firebaseServices.dart';
import 'package:nike_store/tabs/hometab.dart';
import 'package:nike_store/tabs/savedtab.dart';
import 'package:nike_store/tabs/searchtab.dart';
import 'package:nike_store/widget/bottomtabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabspagecontroller;
  int _selectedtab;

  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    print('${firebaseServices.getUserId()}');
    _tabspagecontroller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabspagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabspagecontroller,
                onPageChanged: (num) {
                  setState(() {
                    _selectedtab = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedTab(),
                ],
              ),
            ),
            BottomTabs(
              selectedtab: _selectedtab,
              tabbpressed: (num) {
                _tabspagecontroller.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              },
            ),
          ],
        ),
      ),
    );
  }
}
