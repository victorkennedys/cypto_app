import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/components/advert/user_adverts_stream.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/constants.dart';
import 'package:woof/models/dog_owner_model.dart';
import 'package:woof/screens/booking%20process/pick_dog_screen.dart';
import '../components/nav_bar.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User loggedInUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> userData = {};

  getUserData() async {
    userData = await DogOwnerModel().getCurrentUser();
    print(userData);
  }

  @override
  void initState() {
    getCurrentUser();
    getUserData();

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: BlackPinkText(
                      blackText: "Välkommen till",
                      pinkText: "Woof",
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        /* mainAxisAlignment: MainAxisAlignment.end, */
                        children: [
                          UserAdvertsStream(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    AppButton(
                        buttonColor: kPurpleColor,
                        textColor: kPinkColor,
                        onPressed: () {
                          Navigator.pushNamed(context, PickDogScreen.id);
                        },
                        buttonText: "Promenad"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    AppButton(
                        buttonColor: kPinkColor,
                        textColor: kPurpleColor,
                        onPressed: () {},
                        buttonText: "Hundpassning"),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(0),
    );
  }
}
