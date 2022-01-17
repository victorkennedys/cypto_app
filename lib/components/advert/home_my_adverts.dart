import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/advert/advert.dart';
import 'package:intl/intl.dart';

final _auth = FirebaseAuth.instance;
final User? loggedInUser = _auth.currentUser;
final _firestore = FirebaseFirestore.instance;

class UserAdvertsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("adverts")
          .where('creator', isEqualTo: loggedInUser?.phoneNumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Advert> advertsList = [];
        final allAdverts = snapshot.data?.docs;

        for (var advert in allAdverts!) {
          final advertId = advert.id;
          final dogList = advert.get("dogs");
          final dateTime = advert.get("datetime");
          final owner = advert.get("creator");
          final meetUpSpot = advert.get("meetup spot");
          final bookingType = advert.get("booking type");

          String firstDogID = dogList[0].toString();
          String convertedDateTime =
              DateFormat('EEEE').format(dateTime.toDate());

          advertsList.add(
            Advert(
              advertId: advertId,
              dateTime: convertedDateTime,
              owner: owner,
              meetUpSpot: meetUpSpot,
              dogId: firstDogID,
              bookingType: bookingType,
              dogList: dogList,
              onlyUser: true,
            ),
          );
        }
        return Column(
          children: advertsList,
        );
      },
    );
  }
}
