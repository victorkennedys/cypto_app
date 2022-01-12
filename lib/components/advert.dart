import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class Advert extends StatelessWidget {
  final String advertId;
  final Timestamp dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;

  Advert(
      {required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId});

  @override
  Widget build(BuildContext context) {
    CollectionReference dogs = FirebaseFirestore.instance.collection('dogs');
    return FutureBuilder<DocumentSnapshot>(
        future: dogs.doc(dogId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final image = data['image1'];

            return Container(
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPurpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }
          return Text("loading");
        });
  }
}
