import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/user_dog_list.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/booking%20process/walk_booking_screen.dart';
import '../../main.dart';

class PickDogScreen extends StatelessWidget {
  static const String id = 'pick_dog_screen';

  List<String> dogList = [];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: BlackPinkText(
                    blackText: "Vilka hundar behöver", pinkText: "promenad?"),
                flex: 1,
              ),
              Flexible(
                flex: 4,
                child: UserDogList(
                  selectable: true,
                  advertDogList: dogList,
                  showAllDogs: true,
                ),
              ),
              Flexible(
                child: SizedBox(),
              ),
              Flexible(
                child: AppButton(
                  buttonColor: kPurpleColor,
                  textColor: kPinkColor,
                  buttonText: "Fortsätt",
                  onPressed: () {
                    if (dogList.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookWalkScreen(dogList),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
