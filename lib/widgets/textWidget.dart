import 'package:flutter/material.dart';

//bold text
Widget boldtext(
    {required text,
      required double fontsize,
      TextAlign? textAlign,
      Color? color}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontFamily: "Poppins",
        fontSize: fontsize,
        fontWeight: FontWeight.w700),
  );
}

//semi bold text
Widget semiboldtext(
    {required text,
      required double fontsize,
      TextAlign? textAlign,
      Color? color}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontFamily: "Poppins",
        fontSize: fontsize,
        fontWeight: FontWeight.w600),
  );
}

//medium text
Widget mediumtext(
    {required text,
      required double fontsize,
      TextAlign? textAlign,
      Color? color}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontFamily: "Poppins",
        fontSize: fontsize,
        fontWeight: FontWeight.w500),
  );
}

//regular text
Widget regulartext(
    {required text,
      required double fontsize,
      TextAlign? textAlign,
      Color? color}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontFamily: "Poppins",
        fontSize: fontsize,
        fontWeight: FontWeight.w400),
  );
}
