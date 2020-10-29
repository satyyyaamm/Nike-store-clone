import 'package:flutter/material.dart';
import 'package:nike_store/widget/customactionbar.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text('Home tab'),
          ),
          CustomActionBar(
            title: 'Saved',
            hasBackArrow: false,
            hasTitle: true,
          ),
        ],
      ),
    );
  }
}
