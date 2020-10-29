import 'package:flutter/material.dart';
import 'package:nike_store/constants/contants.dart';

class CustomInput extends StatelessWidget {
  final String hinttext;
  final Function(String) onchanged;
  final Function(String) onsubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool obscuretext;

  const CustomInput(
      {Key key,
      this.hinttext,
      this.onchanged,
      this.onsubmitted,
      this.focusNode,
      this.textInputAction,
      this.obscuretext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 08),
      decoration: BoxDecoration(
        color: Color(0xFFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onchanged,
        onSubmitted: onsubmitted,
        textInputAction: textInputAction,
        obscureText: obscuretext ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          hintText: hinttext,
          border: InputBorder.none,
        ),
        style: Constants.regulardarktext,
      ),
    );
  }
}
