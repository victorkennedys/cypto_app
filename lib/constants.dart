import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kBgColor = Color(0xffF9F9FA);
Color kPurpleColor = Color(0xff562D97);
Color kPinkColor = Color(0xffFFC0AF);

var kH1Text = GoogleFonts.montserrat(
    color: Colors.black, fontWeight: FontWeight.w600, fontSize: 30);

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

AppBar kAppBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0.0,
);

SnackBar kSnackBar(String errorMessage) {
  return SnackBar(
    backgroundColor: kPinkColor,
    content: Text(
      errorMessage,
      textAlign: TextAlign.center,
      style: kH1Text.copyWith(fontSize: 15, color: Colors.white),
    ),
  );
}

String stripePublishableKey =
    'pk_test_51KJLYfE9jxaLNJQBKxEFPjyUIFBm4Mb1RIAnu3Qcew2VcxmmEetsh7ufoNtErBny80hHoS7SszQLeO2sEJEaDDOc00VwxAxku6';

String stripeSecretKey =
    'sk_test_51KJLYfE9jxaLNJQBUzDVtX7pBybhOQ3655ic5HZgbK4SrGap1y45NgZKggMuA0Gd2F5cq8GP7oqUlhGpNAsQu1UM00m7OcPd7G';
