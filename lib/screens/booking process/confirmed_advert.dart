import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/dog/user_dog_list.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/home_screen.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final user = _auth.currentUser;

class ConfirmedAdvert extends StatelessWidget {
  final List<String> dogList;
  final int length;
  final DateTime dateTime;
  final String meetupSpot;

  ConfirmedAdvert(this.dogList, this.length, this.dateTime, this.meetupSpot);

  getDogData() async {
    if (dogList.length == 1) {
      final document = await _firestore.collection('dogs').doc(dogList[0]);
      return document;
    }
  }

  CollectionReference dogs = _firestore.collection('dogs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: dogs.doc(dogList[0]).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final imageUrl = data['image1'];
            final name = data['name'];
            final birthDay = data['birthday'];
            final breed = data['breed'];
            final age = data['age'];
            return CurrentAdvertInfo(
              imageUrl: imageUrl,
              name: name,
              birthDay: birthDay,
              breed: breed,
              ageString: age,
              dogList: dogList,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CurrentAdvertInfo extends StatelessWidget {
  final String imageUrl;
  final String name;
  final Timestamp birthDay;
  final String breed;
  final String ageString;
  final List<String> dogList;
  CurrentAdvertInfo(
      {required this.imageUrl,
      required this.name,
      required this.birthDay,
      required this.breed,
      required this.ageString,
      required this.dogList});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          color: kPurpleColor,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 40,
              left: MediaQuery.of(context).size.width / 12,
              right: MediaQuery.of(context).size.width / 12,
              bottom: MediaQuery.of(context).size.height / 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlackPinkText(blackText: "Promenad med", pinkText: "Zoe"),
                UserDogList(
                  selectable: false,
                  advertDogList: dogList,
                  showAllDogs: false,
                ),
                Column(
                  children: [
                    ExplainerCard(),
                    AppButton(
                        buttonColor: kPurpleColor,
                        textColor: kPinkColor,
                        onPressed: () {
                          Navigator.pushNamed(context, Home.id);
                        },
                        buttonText: "Klar"),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ExplainerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
            /* border: Border.all(width: 1, color: Colors.black54) */),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.only(top: 8.0, bottom: 8.0, left: 15, right: 30),
            child: Text(
              "Du får en notis varje gång en hundpassare ansöker för att hjälpa Zoe",
              textAlign: TextAlign.left,
              style:
                  GoogleFonts.montserrat(color: Colors.black87, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
