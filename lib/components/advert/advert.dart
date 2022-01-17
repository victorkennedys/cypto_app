import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/advert/user_advert.dart';
import 'grid_item.dart';

class Advert extends StatelessWidget {
  final String advertId;
  final String dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;
  final String bookingType;
  final List dogList;
  final bool onlyUser;

  const Advert(
      {Key? key,
      required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType,
      required this.dogList,
      required this.onlyUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference dogs = FirebaseFirestore.instance.collection('dogs');
    return FutureBuilder<DocumentSnapshot>(
      future: dogs.doc(dogId).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data?.data() as Map<String, dynamic>;
          final image = data['image1'];
          final dogName = data['name'];
          if (onlyUser) {
            return UserAdvert(
              advertId: advertId,
              dateTime: dateTime,
              owner: owner,
              meetUpSpot: meetUpSpot,
              dogId: dogId,
              bookingType: bookingType,
              dogList: dogList,
              image1: image,
              dogName: dogName,
            );
          } else {
            return GridItem(
              image: image,
              dogName: dogName,
              advertId: advertId,
              dateTime: dateTime,
              owner: owner,
              meetUpSpot: meetUpSpot,
              dogId: dogId,
              bookingType: bookingType,
              dogList: dogList,
            );
          }
        }
        return const Text("loading");
      },
    );
  }
}
