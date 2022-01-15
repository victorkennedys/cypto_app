import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/add_dog_to_profile.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/form_question_text.dart';
import 'package:woof/components/input_field.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/home_screen.dart';

class UserEnterInfoScreen extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<UserEnterInfoScreen> createState() => _UserEnterInfoScreenState();
}

class _UserEnterInfoScreenState extends State<UserEnterInfoScreen> {
  String name = '';
  String email = '';

  setName(value) {
    setState(() {
      name = value;
    });
  }

  setEmail(value) {
    setState(() {
      email = value;
    });
  }

  List<bool> buttonSelected = [false, false];
  List<String> docIdList = [];
  List<AddDogWidget> addDogWidgetList = [];

  setDocId(String id) {
    docIdList.add(id);
    setState(() {
      docIdList;
    });
    print(docIdList);
  }

  @override
  void initState() {
    addDogWidgetList.add(AddDogWidget(setDocId));

    super.initState();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: BlackPinkText(
                      blackText: "Välkommen till", pinkText: "woof")),
              Flexible(
                flex: 3,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormQuestionText("Vad heter du?"),
                        InputField("Ange ditt namn", true, setName),
                        FormQuestionText("Hur många hundar har du?"),
                        Column(
                          children: [
                            Column(
                              children: addDogWidgetList,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (addDogWidgetList[
                                          addDogWidgetList.length - 1]
                                      .dogData
                                      .isNotEmpty) {
                                    setState(() {
                                      addDogWidgetList.add(
                                        AddDogWidget(setDocId),
                                      );
                                    });
                                  }
                                },
                                child: Text("Lägg till en till hund"),
                              ),
                            )
                          ],
                        ),
                        FormQuestionText("Vad är din email?"),
                        InputField("Ange din email", true, setEmail),
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
                        addUSerDataToFireBase();
                      },
                      buttonText: "Klar"))
            ],
          ),
        ),
      ),
    );
  }

  addUSerDataToFireBase() {
    final userDoc = FirebaseFirestore.instance.collection('dog owners');
    userDoc.doc(widget.user?.phoneNumber).set({
      'phone': widget.user?.phoneNumber,
      'name': name,
      'email': email,
      'dogs': docIdList
    });
    Navigator.pushNamed(context, Home.id);
  }
}
