import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/dog/add_dog_widget.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/input_field.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/home_screen.dart';

class UserEnterInfoScreen extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;
  static const String id = 'user_info_screen';

  @override
  State<UserEnterInfoScreen> createState() => _UserEnterInfoScreenState();
}

class _UserEnterInfoScreenState extends State<UserEnterInfoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: kAppBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                    /*   mainAxisAlignment: MainAxisAlignment.spaceBetween, */
                    children: [
                      BlackPinkText(
                          blackText: "Välkommen till", pinkText: "woof"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormQuestionText("Vad heter du?"),
                          InputField("Ange ditt namn", true, setName, null),
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
                                  child: const Text("Lägg till en till hund"),
                                ),
                              )
                            ],
                          ),
                          FormQuestionText("Vad är din email?"),
                          InputField("Ange din email", true, setEmail, null),
                        ],
                      ),
                      AppButton(
                          buttonColor: kPurpleColor,
                          textColor: kPinkColor,
                          onPressed: () {
                            if (name.isNotEmpty &&
                                email.isNotEmpty &&
                                docIdList.isNotEmpty) {
                              addUSerDataToFireBase();
                            } else if (name.isEmpty) {
                              showSnackBar("Ange ditt namn", context);
                            } else if (email.isEmpty) {
                              showSnackBar("Ange din email", context);
                            } else if (docIdList.isEmpty) {
                              showSnackBar("Lägg till minst en hund", context);
                            }
                          },
                          buttonText: "Klar"),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(String errorMessage, BuildContext context) {
    _scaffoldKey.currentState?.showSnackBar(
      kSnackBar(errorMessage),
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Home.id, (Route<dynamic> route) => false);
  }
}
