import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/dog/dog_card.dart';
import 'package:woof/constants.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User loggedInUser = _auth.currentUser!;

class DogModel {
  returnDogList(
      {required bool selectable,
      required bool showAllDogs,
      List<String>? advertDogList,
      Function? callBack}) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("dogs")
            .where("owner",
                isEqualTo: loggedInUser.email ?? loggedInUser.phoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final allDogs = snapshot.data?.docs;

          List<DogCard> dogList = [];
          for (var dog in allDogs!) {
            final dogCard = DogCard(
              docId: dog.id,
              name: dog.get("name"),
              breed: dog.get("breed"),
              birthDay: (dog.get("birthday") as Timestamp).toDate(),
              imageUrl: dog.get("image1"),
              selectable: selectable,
              dogList: advertDogList ?? null,
              age: dog.get("age"),
              nameCallBack: callBack ?? null,
            );
            showAllDogs
                ? dogList.add(dogCard)
                : {
                    if (advertDogList!.contains(dog.id)) {dogList.add(dogCard)}
                  };
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
                child: showAllDogs
                    ? ListView(
                        children: dogList,
                      )
                    : Column(
                        children: dogList,
                      ),
              ),
            ),
          );
        });
  }
}
