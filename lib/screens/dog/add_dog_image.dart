import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/dog/add_dog_image.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:woof/screens/dog/add_dog.dart';

class AddDogImage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser = _auth.currentUser!;
  List<String> urlList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: MediaQuery.removePadding(
        context: context,
        child: Padding(
          padding: Woof.defaultPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlackPinkText(blackText: "Lägg till en bild på", pinkText: "Zoe"),
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
              AppButton(
                  buttonColor: kPurpleColor,
                  textColor: kPinkColor,
                  onPressed: () async {
                    Map<String, dynamic> data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDogScreen(urlList),
                      ),
                    );
                    Navigator.pop(context, data);
                  },
                  buttonText: "Klar")
            ],
          ),
        ),
      ),
    );
  }
}
