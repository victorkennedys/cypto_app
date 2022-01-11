import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import '../components/form_question_text.dart';
import '../constants.dart';
import '../components/add_dog_image.dart';

final _firestore = FirebaseFirestore.instance;
List urlList = [];

class AddDogScreen extends StatefulWidget {
  static const String id = 'add_dog_screen';

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _auth = FirebaseAuth.instance;

  late User loggedInUser = _auth.currentUser!;

  String dogName = '';

  String breed = '';

  DateTime birthDay = DateTime.now();

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
                height: MediaQuery.of(context).size.height * 0.6,
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
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now());

                        if (picked != null) {
                          setState(() {
                            birthDay = picked;
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          enabled: false,
                          decoration: kInputDecoration.copyWith(
                              hintText: "${birthDay.toString()}"),
                        ),
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
                Navigator.pop(context);
              },
              buttonText: "Klar")
        ],
      ),
    );
  }
}
