import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/date_selector.dart';
import 'package:woof/components/input%20widgets/input_field.dart';
import 'package:woof/components/input%20widgets/toggle_button.dart';
import 'package:woof/screens/dog/add_dog_image.dart';
import '../../components/input widgets/form_question_text.dart';
import '../../constants.dart';
import '../../components/dog/add_dog_image.dart';
import '../../main.dart';

final _firestore = FirebaseFirestore.instance;
List urlList = [];

class AddDogScreen extends StatefulWidget {
  static const String id = 'add_dog_screen';

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser = _auth.currentUser!;
  List<bool> genderButtonSelected = [false, false];
  List<bool> sizeButtonSelected = [false, false, false];
  String dogName = '';
  String breed = '';
  DateTime? birthDay;
  String gender = '';
  String size = '';

  setName(String value) {
    setState(() {
      dogName = value;
    });
  }

  setBreed(String value) {
    setState(() {
      breed = value;
    });
  }

  setDate(DateTime date) {
    setState(() {
      birthDay = date;
    });
  }

  changeActiveGenderButton(int index) {
    setState(() {
      print(index);
      if (index == 0) {
        genderButtonSelected[0] = true;
        genderButtonSelected[1] = false;
        gender = "female";
      }
      if (index == 1) {
        genderButtonSelected[0] = false;
        genderButtonSelected[1] = true;
        gender = "male";
      }
    });
  }

  changeActiveSizeButton(int index) {
    setState(() {
      print(index);
      if (index == 0) {
        sizeButtonSelected[0] = true;
        sizeButtonSelected[1] = false;
        sizeButtonSelected[2] = false;
        size = "small";
      }
      if (index == 1) {
        sizeButtonSelected[0] = false;
        sizeButtonSelected[1] = true;
        sizeButtonSelected[2] = false;
        size = "medium";
      }
      if (index == 2) {
        sizeButtonSelected[0] = false;
        sizeButtonSelected[1] = false;
        sizeButtonSelected[2] = true;
        size = "big";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      /* resizeToAvoidBottomInset: false, */
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: Woof.defaultPadding(context),
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlackPinkText(
                  blackText: "Lägg till din",
                  pinkText: "hund",
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FormQuestionText('Lägg till en bild på din hund'),
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
                    InputField("Namn", true, setName),
                    FormQuestionText("Vad har du för hundras"),
                    InputField("Hundras", true, setBreed),
                    FormQuestionText("När är din hund född?"),
                    DateSelector(setDate),
                    FormQuestionText("Vad är din hund för kön?"),
                    TogButtons(
                        changeActiveGenderButton,
                        genderButtonSelected,
                        "Hona",
                        "Hane",
                        null,
                        2,
                        'images/woman.png',
                        'images/male.png',
                        null),
                    FormQuestionText("Hur stor är din hund?"),
                    TogButtons(changeActiveSizeButton, sizeButtonSelected,
                        "Liten", "Mellan", "Stor", 3, null, null, null),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                AppButton(
                    buttonColor: kPurpleColor,
                    textColor: kPinkColor,
                    onPressed: () {
                      final dogAge =
                          ((DateTime.now().toUtc().millisecondsSinceEpoch) -
                                  (birthDay!.toUtc().millisecondsSinceEpoch)) /
                              1000 /
                              60 /
                              60 /
                              24;
                      print(dogAge);
                      if (dogName.isNotEmpty &&
                          size.isNotEmpty &&
                          gender.isNotEmpty &&
                          breed.isNotEmpty &&
                          birthDay != null &&
                          dogAge >= 30) {
                        addDogToFireBase();
                      } else if (dogName.isEmpty) {
                        showSnackBar("Du måste fylla i hundens namn", context);
                      } else if (size.isEmpty) {
                        showSnackBar("Fyll i hundens storlek", context);
                      } else if (gender.isEmpty) {
                        showSnackBar("Ange hundens kön", context);
                      } else if (dogAge <= 30) {
                        showSnackBar("Ogiltigt födelsedatum", context);
                      }
                    },
                    buttonText: "Klar")
              ],
            ),
          ]),
        ),
      ),
    );
  }

  showSnackBar(String errorMessage, BuildContext context) {
    _scaffoldKey.currentState?.showSnackBar(
      kSnackBar(errorMessage),
    );
  }

  addDogToFireBase() {
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
      _firestore
          .collection('dogs')
          .doc("${loggedInUser.phoneNumber}$dogName")
          .set({
        'name': dogName,
        'image1': urlList[0].toString(),
        'breed': breed,
        'birthday': birthDay,
        'owner': loggedInUser.email ?? loggedInUser.phoneNumber,
        'age': ageString,
        'gender': gender,
        'size': size
      });
    } else if (urlList.length == 2) {
      _firestore
          .collection('dogs')
          .doc("${loggedInUser.phoneNumber}$dogName")
          .set({
        'name': dogName,
        'image1': urlList[0].toString(),
        'image2': urlList[1].toString(),
        'breed': breed,
        'birthday': birthDay,
        'owner': loggedInUser.email ?? loggedInUser.phoneNumber,
        'age': ageString,
        'gender': gender,
        'size': size
      });
    } else if (urlList.length == 3) {
      _firestore
          .collection('dogs')
          .doc("${loggedInUser.phoneNumber}$dogName")
          .set({
        'name': dogName,
        'image1': urlList[0].toString(),
        'image2': urlList[1].toString(),
        'image3': urlList[2].toString(),
        'breed': breed,
        'birthday': birthDay,
        'owner': loggedInUser.email ?? loggedInUser.phoneNumber,
        'age': ageString,
        'gender': gender,
        'size': size
      });
    }

    Navigator.of(context).pop({
      "dogName": dogName,
      "imageUrl": urlList[0],
      'docId': "${loggedInUser.phoneNumber}_$dogName"
    });

    urlList.clear();
  }
}
