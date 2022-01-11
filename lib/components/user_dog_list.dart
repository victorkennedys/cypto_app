import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/dog_avatar.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class UserDogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DogStream();
  }
}

class DogCard extends StatelessWidget {
  final String name;
  final String breed;
  final String birthDay;
  final String imageUrl;

  DogCard(
      {required this.name,
      required this.breed,
      required this.birthDay,
      required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 10,
        right: MediaQuery.of(context).size.width / 10,
      ),
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DogAvatar(imageUrl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name),
                  Text(breed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DogStream extends StatelessWidget {
  const DogStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("dogs")
            .where("owner", isEqualTo: loggedInUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final allDogs = snapshot.data?.docs;
          List<DogCard> dogList = [];
          for (var dog in allDogs!) {
            final dogName = dog.get("name");
            final breed = dog.get("breed");
            final birthDay = dog.get("burthday");
            final image = dog.get("image1");

            final dogCard = DogCard(
              name: dogName,
              breed: breed,
              birthDay: birthDay,
              imageUrl: image,
            );
            dogList.add(dogCard);
          }
          return Column(
            children: dogList,
          );
        });
  }
}
