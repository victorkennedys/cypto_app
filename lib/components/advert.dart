import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/adverts/current_advert.dart';

class Advert extends StatelessWidget {
  final String advertId;
  final Timestamp dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;
  final String bookingType;
  final List dogList;

  const Advert(
      {Key? key,
      required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType,
      required this.dogList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference dogs = FirebaseFirestore.instance.collection('dogs');
    return FutureBuilder<DocumentSnapshot>(
        future: dogs.doc(dogId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
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
              dogList: dogList,
            );
          }
          return const Text("loading");
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
  final List dogList;

  const GridItem(
      {Key? key,
      required this.image,
      required this.dogName,
      required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType,
      required this.dogList})
      : super(key: key);

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
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.srcOver)),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  dogList.length == 1
                      ? "Promenad med $dogName"
                      : dogList.length.toString(),
                  style: kH1Text.copyWith(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
