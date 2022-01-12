import 'package:flutter/material.dart';
import 'package:woof/components/dog_avatar.dart';
import 'package:woof/screens/logged%20in%20user%20dog/current_dog.dart';
import 'package:woof/constants.dart';

class DogCard extends StatefulWidget {
  final String docId;
  final String name;
  final String breed;
  final DateTime birthDay;
  final String imageUrl;
  final bool selectable;
  final List<String>? dogList;

  DogCard(
      {required this.docId,
      required this.name,
      required this.breed,
      required this.birthDay,
      required this.imageUrl,
      required this.selectable,
      this.dogList});

  @override
  State<DogCard> createState() => _DogCardState();
}

class _DogCardState extends State<DogCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectable == false
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDog(
                          name: widget.name,
                          breed: widget.breed,
                          birthDay: widget.birthDay,
                          image1: widget.imageUrl,
                        )),
              )
            : () {
                //if selectable nothing happens onPressed
              };
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DogAvatar(widget.imageUrl),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name),
                    Text(widget.breed),
                  ],
                ),
              ],
            ),
            widget.selectable == true
                ? GestureDetector(
                    onTap: () {
                      if (isSelected == false) {
                        widget.dogList!.add(widget.docId);
                        setState(() {
                          isSelected = true;
                        });
                      } else if (isSelected == true) {
                        widget.dogList!.remove(widget.docId);
                        setState(() {
                          isSelected = false;
                        });
                      }
                    },
                    child: Container(
                      child: Icon(
                        Icons.check,
                        color: isSelected ? kPurpleColor : Colors.transparent,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
