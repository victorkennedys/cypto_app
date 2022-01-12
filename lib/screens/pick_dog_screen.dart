import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/user_dog_list.dart';
import 'package:woof/constants.dart';

class PickDogScreen extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  static const String id = 'pick_dog_screen';

  List<String> dogList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
            top: MediaQuery.of(context).size.height / 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: BlackPinkText(
                    blackText: "Vilka hundar behöver", pinkText: "promenad?"),
                flex: 1,
              ),
              Flexible(
                flex: 4,
                child: UserDogList(selectable: true, advertDogList: dogList),
              ),
              Flexible(
                child: SizedBox(),
              ),
              Flexible(
                child: AppButton(
                  buttonColor: kPurpleColor,
                  textColor: kPinkColor,
                  buttonText: "Fortsätt",
                  onPressed: () {
                    if (dogList.isNotEmpty) {
                      _firestore.collection("adverts").add({'dogs': dogList});
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
