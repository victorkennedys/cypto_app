import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/advert/advert_builder.dart';
import 'package:intl/intl.dart';
import 'package:woof/constants.dart';

final _auth = FirebaseAuth.instance;
final User? loggedInUser = _auth.currentUser;
final _firestore = FirebaseFirestore.instance;

class UserAdvertsStream extends StatelessWidget {
  const UserAdvertsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("adverts")
          .where('creator', isEqualTo: loggedInUser?.phoneNumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw Exception("problem getting user adverts");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<AdvertBuilder> advertsList = [];
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
            AdvertBuilder(
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
        if (advertsList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Kommande annonser",
                    style: TextStyle(
                        fontSize: 15,
                        color: kPurpleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: advertsList,
                )
              ],
            ),
          );
        } else {
          return const Text(
            "Du har inga annonser",
            style: TextStyle(fontSize: 15),
          );
        }
      },
    );
  }
}
