import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/nav_bar.dart';
import 'package:woof/components/user_dog_list.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/dog/add_dog.dart';

User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class MyDogs extends StatefulWidget {
  static const String id = 'my_dogs_screen';

  @override
  State<MyDogs> createState() => _MyDogsState();
}

class _MyDogsState extends State<MyDogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 3,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  Expanded(
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ],
        ),
      ), */
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
            top: MediaQuery.of(context).size.height / 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: 1,
                  child: BlackPinkText(blackText: "Dina", pinkText: "Hundar")),
              Flexible(
                flex: 4,
                child: UserDogList(
                  selectable: false,
                  showAllDogs: true,
                ),
              ),
              Flexible(
                child: SizedBox(),
              ),
              Flexible(
                child: AppButton(
                  textColor: kPinkColor,
                  buttonColor: kPurpleColor,
                  buttonText: "Lägg till en hund",
                  onPressed: () {
                    Navigator.pushNamed(context, AddDogScreen.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(1),
    );
  }
}
