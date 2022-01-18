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
      extendBodyBehindAppBar: true,
      appBar: kAppBar,
      body: MediaQuery.removePadding(
        context: context,
        child: Padding(
          padding: Woof.defaultPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlackPinkText(
                        blackText: "Lägg till en bild på", pinkText: "hunden"),
                  ],
                ),
              ),
              AddImageOfDog(200, 200, urlList),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AppButton(
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
                    buttonText: "Klar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
