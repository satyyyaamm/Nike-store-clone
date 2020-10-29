import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedtab;
  final Function(int) tabbpressed;

  const BottomTabs({Key key, this.selectedtab, this.tabbpressed})
      : super(key: key);
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;
  @override
  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedtab ?? 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomTabButton(
            imagelink: 'assets/images/tab_home.png',
            selected: _selectedTab == 0 ? true : false,
            onpressed: () {
              widget.tabbpressed(0);
            },
          ),
          BottomTabButton(
            imagelink: 'assets/images/tab_search.png',
            selected: _selectedTab == 1 ? true : false,
            onpressed: () {
              widget.tabbpressed(1);
            },
          ),
          BottomTabButton(
            imagelink: 'assets/images/tab_saved.png',
            selected: _selectedTab == 2 ? true : false,
            onpressed: () {
              widget.tabbpressed(2);
            },
          ),
          BottomTabButton(
            imagelink: 'assets/images/tab_logout.png',
            selected: _selectedTab == 3 ? true : false,
            onpressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final String imagelink;
  final bool selected;
  final Function onpressed;

  const BottomTabButton(
      {Key key, this.imagelink, this.selected, this.onpressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 26.0,
          horizontal: 24.0,
        ),
        child: Image.asset(
          imagelink ?? 'assets/images/tab_home.png',
          width: 22.0,
          height: 22.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
