import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dog_card.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class UserDogList extends StatelessWidget {
  final bool selectable;
  final List<String>? advertDogList;
  final bool showAllDogs;
  final Function? callBack;

  UserDogList(
      {required this.selectable,
      this.advertDogList,
      required this.showAllDogs,
      this.callBack});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("dogs")
            .where("owner",
                isEqualTo: loggedInUser.email ?? loggedInUser.phoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final allDogs = snapshot.data?.docs;

          List<DogCard> dogList = [];
          for (var dog in allDogs!) {
            if (showAllDogs == true) {
              final docId = dog.id;
              final dogName = dog.get("name");
              final breed = dog.get("breed");
              final birthDay = (dog.get("birthday") as Timestamp).toDate();
              final image1 = dog.get("image1");
              final age = dog.get("age");

              final dogCard = DogCard(
                docId: docId,
                name: dogName,
                breed: breed,
                birthDay: birthDay,
                imageUrl: image1,
                selectable: selectable,
                dogList: advertDogList ?? null,
                age: age,
                nameCallBack: callBack,
              );
              dogList.add(dogCard);
            } else {
              if (advertDogList!.contains(dog.id)) {
                final docId = dog.id;
                final dogName = dog.get("name");
                final breed = dog.get("breed");
                final birthDay = (dog.get("birthday") as Timestamp).toDate();
                final image1 = dog.get("image1");
                final age = dog.get("age");

                final dogCard = DogCard(
                  docId: docId,
                  name: dogName,
                  breed: breed,
                  birthDay: birthDay,
                  imageUrl: image1,
                  selectable: selectable,
                  dogList: advertDogList ?? null,
                  age: age,
                );
                dogList.add(dogCard);
              }
            }
          }
          return Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: dogList,
                ),
              ),
            ),
          );
        });
  }
}
