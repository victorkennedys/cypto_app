import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kBgColor = Color(0xffF9F9FA);
Color kPurpleColor = Color(0xff562D97);
Color kPinkColor = Color(0xffFFC0AF);

var h1Text = GoogleFonts.montserrat(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35);

var kInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPinkColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
