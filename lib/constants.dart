import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kBgColor = Color(0xffF9F9FA);
Color kPurpleColor = Color(0xff562D97);
Color kPinkColor = Color(0xffFFC0AF);

var kH1Text = GoogleFonts.montserrat(
    color: Colors.black, fontWeight: FontWeight.w600, fontSize: 35);

var kInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPinkColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

var kButtonTextStyle = GoogleFonts.montserrat(
  color: kPurpleColor,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
