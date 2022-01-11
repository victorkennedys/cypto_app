import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/dog_avatar.dart';
import 'package:woof/screens/current_dog.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class UserDogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("dogs")
            .where("owner", isEqualTo: loggedInUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("it has data");
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final allDogs = snapshot.data?.docs;

          List<DogCard> dogList = [];
          for (var dog in allDogs!) {
            final dogName = dog.get("name");
            final breed = dog.get("breed");
            final birthDay = (dog.get("birthday") as Timestamp).toDate();
            final image1 = dog.get("image1");

            final dogCard = DogCard(
              name: dogName,
              breed: breed,
              birthDay: birthDay,
              imageUrl: image1,
            );
            dogList.add(dogCard);
          }
          return Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: dogList,
                ),
              ),
            ),
          );
        });
  }
}

class DogCard extends StatelessWidget {
  final String name;
  final String breed;
  final DateTime birthDay;
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CurrentDog(
                      name: name,
                      breed: breed,
                      birthDay: birthDay,
                      image1: imageUrl,
                    )),
          );
        },
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
