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

  DateTime? birthDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: BlackPinkText(
                  blackText: "Lägg till din",
                  pinkText: "hund",
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    elevation: 8.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: FormQuestionText(
                                "Ladda upp en bild på din hund")),
                        Expanded(
                          child: Padding(
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
                        ),
                        Expanded(
                            child: FormQuestionText("Vad heter din hund?")),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              decoration: kInputDecoration.copyWith(
                                  hintText: "Vad heter din hund?"),
                              onChanged: (value) {
                                dogName = value;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: FormQuestionText("Vad har du för hundras")),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              decoration: kInputDecoration.copyWith(
                                  hintText: "Hundras"),
                              onChanged: (value) {
                                breed = value;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: FormQuestionText("När är din hund född?")),
                        Expanded(
                          child: GestureDetector(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: AppButton(
                    buttonColor: kPurpleColor,
                    textColor: kPinkColor,
                    onPressed: () {
                      if (dogName.isNotEmpty &&
                          breed.isNotEmpty &&
                          birthDay != null &&
                          (DateTime.now().toUtc().millisecondsSinceEpoch -
                                      birthDay!
                                          .toUtc()
                                          .millisecondsSinceEpoch) /
                                  1000 /
                                  60 /
                                  60 /
                                  24 >=
                              30) {
                        int age;
                        String ageString;
                        if (DateTime.now().year != birthDay!.year) {
                          age = DateTime.now().year - birthDay!.year;
                          ageString = age.toString() + "år";
                        } else {
                          age = DateTime.now().month - birthDay!.month;
                          ageString = age.toString() + "månader";
                        }
                        if (urlList.length == 1) {
                          _firestore.collection('dogs').add({
                            'name': dogName,
                            'image1': urlList[0].toString(),
                            'breed': breed,
                            'birthday': birthDay,
                            'owner': loggedInUser.email,
                            'age': ageString
                          });
                        } else if (urlList.length == 2) {
                          _firestore.collection('dogs').add({
                            'name': dogName,
                            'image1': urlList[0].toString(),
                            'image2': urlList[1].toString(),
                            'breed': breed,
                            'birthday': birthDay,
                            'owner': loggedInUser.email,
                            'age': ageString
                          });
                        } else if (urlList.length == 3) {
                          _firestore.collection('dogs').add({
                            'name': dogName,
                            'image1': urlList[0].toString(),
                            'image2': urlList[1].toString(),
                            'image3': urlList[2].toString(),
                            'breed': breed,
                            'birthday': birthDay,
                            'owner': loggedInUser.email,
                            'age': ageString,
                          });
                        }
                        Navigator.pop(context);
                      }
                    },
                    buttonText: "Klar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
