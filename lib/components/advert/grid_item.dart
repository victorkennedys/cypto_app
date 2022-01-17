import 'package:flutter/material.dart';
import 'package:woof/screens/adverts/current_advert.dart';

import '../../constants.dart';

class GridItem extends StatelessWidget {
  final String image;
  final String dogName;
  final String advertId;
  final String dateTime;
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
