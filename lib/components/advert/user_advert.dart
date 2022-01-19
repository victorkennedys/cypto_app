import 'package:flutter/material.dart';
import 'package:woof/components/dog/dog_avatar.dart';
import 'package:woof/screens/adverts/current_advert.dart';

class UserAdvert extends StatelessWidget {
  final String advertId;
  final String dateTime;
  final String owner;
  final String meetUpSpot;
  final String dogId;
  final String bookingType;
  final List dogList;
  final String image1;
  final String dogName;

  const UserAdvert(
      {Key? key,
      required this.advertId,
      required this.dateTime,
      required this.owner,
      required this.meetUpSpot,
      required this.dogId,
      required this.bookingType,
      required this.dogList,
      required this.image1,
      required this.dogName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrentAdvert(
                imageUrl: image1,
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
      child: Container(
        padding: const EdgeInsets.only(bottom: 5, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DogAvatar(image1),
                Container(
                  width: MediaQuery.of(context).size.width / 30,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dogList.length == 1
                                ? "$bookingType för $dogName"
                                : "$bookingType med ${dogList.length} av dina hundar",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            dateTime,
                            style: const TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
