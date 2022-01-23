import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woof/models/dog_owner_model.dart';

import 'dog_card.dart';

User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class UserDogList extends StatefulWidget {
  final bool selectable;
  final List<String>? advertDogList;
  final bool showAllDogs;
  final Function? callBack;

  UserDogList(
      {Key? key,
      required this.selectable,
      this.advertDogList,
      required this.showAllDogs,
      this.callBack})
      : super(key: key);

  @override
  State<UserDogList> createState() => _UserDogListState();
}

class _UserDogListState extends State<UserDogList> {
  List<DogCard> dogCardList = [];

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('userDogData');
    /*  print(data); */
    if (data != null) {
      List<Map<String, dynamic>> decodedData = [];
      for (var dog in data) {
        Map<String, dynamic> map = jsonDecode(dog);

        decodedData.add(map);
      }
      for (Map<String, dynamic> dog in decodedData) {
        dogCardList.add(
          DogCard(
            docId: loggedInUser.phoneNumber ?? "",
            name: dog['name'],
            breed: dog['breed'],
            imageUrl: dog['image1'],
            selectable: widget.selectable,
            age: dog['age'],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dogCardList.isNotEmpty
        ? Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: widget.showAllDogs
                    ? ListView(
                        children: dogCardList,
                      )
                    : Column(
                        children: dogCardList,
                      ),
              ),
            ),
          )
        : FutureBuilder(
            future: getUserDogCardList(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
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
                      child: widget.showAllDogs
                          ? ListView(
                              children: snapshot.data as List<DogCard>,
                            )
                          : Column(
                              children: snapshot.data as List<DogCard>,
                            ),
                    ),
                  ),
                );
              }
            },
          );
  }

  Map<String, dynamic> userData = {};

  Future<List<DogCard>> getUserDogCardList(BuildContext context) async {
    userData = await DogOwnerModel().getCurrentUserData();
    List<DogCard> dogCardList = [];
    List<Map<String, dynamic>> userDogList = userData['user dogs data'];
    List<String> encodedList = [];
    for (Map<String, dynamic> dog in userDogList) {
      String stringBirthDay =
          (dog['birthday'] as Timestamp).toDate().toString();
      DateTime dateBirthday = (dog['birthday'] as Timestamp).toDate();
      dog.remove('birthday');
      dog.addAll({'encoded birthday': stringBirthDay});
      String encodedDog = jsonEncode(dog);
      encodedList.add(encodedDog);
      dogCardList.add(
        DogCard(
          docId: loggedInUser.phoneNumber ?? "",
          name: dog['name'],
          breed: dog['breed'],
          imageUrl: dog['image1'],
          selectable: widget.selectable,
          age: dog['age'],
        ),
      );
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('userDogData', encodedList);
    return dogCardList;
  }
}


/* DogModel().returnDogList(
        selectable: selectable,
        showAllDogs: showAllDogs,
        advertDogList: advertDogList,
        callBack: callBack); */