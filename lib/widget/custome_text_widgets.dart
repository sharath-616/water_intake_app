import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final FontWeight? fw;
  final double? fs;
  final double? ls;
  final Color? clr;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fw = FontWeight.normal,
    this.fs = 14.0,
    this.ls = 0.0,
    this.clr = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: clr,
        fontSize: fs,
        fontWeight: fw,
        letterSpacing: ls,
      ),
    );
  }
}
