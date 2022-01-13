import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/nav_bar.dart';
import '../components/advert.dart';

final _firestore = FirebaseFirestore.instance;

class AdvertsScreen extends StatelessWidget {
  static const String id = 'adverts_screen';

  CollectionReference adverts = _firestore.collection('adverts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 40,
                left: MediaQuery.of(context).size.width / 12,
                right: MediaQuery.of(context).size.width / 12,
              ),
              child: BlackPinkText(blackText: "Hundar på", pinkText: "Woof"),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("adverts").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("Error");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Advert> advertsList = [];
                final allAdverts = snapshot.data?.docs;

                for (var advert in allAdverts!) {
                  final advertId = advert.id;
                  final dogList = advert.get("dogs");
                  final dateTime = advert.get("datetime");
                  final owner = advert.get("creator");
                  final meetUpSpot = advert.get("meetup spot");

                  String firstDogID = dogList[0].toString();

                  advertsList.add(
                    Advert(
                      advertId: advertId,
                      dateTime: dateTime,
                      owner: owner,
                      meetUpSpot: meetUpSpot,
                      dogId: firstDogID,
                    ),
                  );
                }
                return Expanded(
                    child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: advertsList,
                ));
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: NavBar(2),
    );
  }
}
