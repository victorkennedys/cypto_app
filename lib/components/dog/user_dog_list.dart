import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/models/dog_list_model.dart';

User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class UserDogList extends StatelessWidget {
  final bool selectable;
  final List<String>? advertDogList;
  final bool showAllDogs;
  final Function? callBack;

  const UserDogList(
      {Key? key,
      required this.selectable,
      this.advertDogList,
      required this.showAllDogs,
      this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DogListModel().returnDogList(
        selectable: selectable,
        showAllDogs: showAllDogs,
        advertDogList: advertDogList,
        callBack: callBack);
  }
}
