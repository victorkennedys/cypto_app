import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/screens/home_screen.dart';
import '../components/form_question_text.dart';
import '../constants.dart';
import '../components/add_dog_image.dart';

final _firestore = FirebaseFirestore.instance;
List urlList = [];

class AddDogScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser = _auth.currentUser!;

  static const String id = 'add_dog_screen';
  String dogName = '';
  String breed = '';
  String birthDay = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlackPinkText(
            blackText: "Lägg till din",
            pinkText: "hund",
            bottomPaddingHigh: true,
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              elevation: 8.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormQuestionText("Ladda upp en bild på din hund"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddImageOfDog(100, 100, urlList),
                          AddImageOfDog(70, 70, urlList),
                          AddImageOfDog(70, 70, urlList),
                        ],
                      ),
                    ),
                    FormQuestionText("Vad heter din hund?"),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        decoration: kInputDecoration.copyWith(
                            hintText: "Vad heter din hund?"),
                        onChanged: (value) {
                          dogName = value;
                        },
                      ),
                    ),
                    FormQuestionText("Vad har du för hundras"),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        decoration:
                            kInputDecoration.copyWith(hintText: "Hundras"),
                        onChanged: (value) {
                          breed = value;
                        },
                      ),
                    ),
                    FormQuestionText("När är din hund född?"),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        decoration: kInputDecoration.copyWith(
                            hintText: "${DateTime.now.toString()}"),
                        onChanged: (value) {
                          birthDay = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppButton(
              buttonColor: kPurpleColor,
              textColor: kPinkColor,
              onPressed: () {
                if (urlList.length == 1) {
                  _firestore.collection('dogs').add({
                    'name': dogName,
                    'image1': urlList[0].toString(),
                    'breed': breed,
                    'birthday': birthDay,
                    'owner': loggedInUser.email
                  });
                } else if (urlList.length == 2) {
                  _firestore.collection('dogs').add({
                    'name': dogName,
                    'image1': urlList[0].toString(),
                    'image2': urlList[1].toString(),
                    'breed': breed,
                    'birthday': birthDay,
                    'owner': loggedInUser.email
                  });
                } else if (urlList.length == 3) {
                  _firestore.collection('dogs').add({
                    'name': dogName,
                    'image1': urlList[0].toString(),
                    'image2': urlList[1].toString(),
                    'image3': urlList[2].toString(),
                    'breed': breed,
                    'birthday': birthDay,
                    'owner': loggedInUser.email
                  });
                }
                Navigator.pushNamed(context, Home.id);
              },
              buttonText: "Klar")
        ],
      ),
    );
  }
}
