import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onpressed;
  final bool outlinedbutton;
  final bool isloading;

  const CustomButton(
      {Key key, this.onpressed, this.text, this.outlinedbutton, this.isloading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlinedbutton = outlinedbutton ?? false;
    bool _isloading = isloading ?? false;

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 08.0,
          horizontal: 24.0,
        ),
        height: 65,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _outlinedbutton ? Colors.transparent : Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0)),
        child: Stack(
          children: [
            Visibility(
              visible: _isloading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: _outlinedbutton ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isloading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
