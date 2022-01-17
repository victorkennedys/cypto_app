import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentAdvert extends StatelessWidget {
  final String imageUrl;
  final String dogName;
  final String advertId;
  final String dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;
  final String bookingType;

  CurrentAdvert(
      {required this.imageUrl,
      required this.dogName,
      required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
