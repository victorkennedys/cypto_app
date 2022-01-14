import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woof/screens/adverts/current_advert.dart';

class Advert extends StatelessWidget {
  final String advertId;
  final Timestamp dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;
  final String bookingType;

  Advert(
      {required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType});

  @override
  Widget build(BuildContext context) {
    CollectionReference dogs = FirebaseFirestore.instance.collection('dogs');
    return FutureBuilder<DocumentSnapshot>(
        future: dogs.doc(dogId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;
            final image = data['image1'];
            final dogName = data['name'];

            return GridItem(
              image: image,
              dogName: dogName,
              advertId: advertId,
              dateTime: dateTime,
              owner: owner,
              meetUpSpot: meetUpSpot,
              dogId: dogId,
              bookingType: bookingType,
            );
          }
          return Text("loading");
        });
  }
}

class GridItem extends StatelessWidget {
  final String image;
  final String dogName;
  final String advertId;
  final Timestamp dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;
  final String bookingType;
  GridItem(
      {required this.image,
      required this.dogName,
      required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrentAdvert(
                imageUrl: image,
                dogName: dogName,
                advertId: advertId,
                dateTime: dateTime,
                owner: owner,
                meetUpSpot: meetUpSpot,
                dogId: dogId,
                bookingType: bookingType),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(dogName),
            ],
          ),
        ],
      ),
    );
  }
}
