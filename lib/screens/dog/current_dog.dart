import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class CurrentDog extends StatelessWidget {
  final String name;
  final String breed;
  final String image1;
  final String age;

//to fix enable image2, image3. (problem = if they exist in firestore)

  CurrentDog(
      {required this.name,
      required this.breed,
      required this.image1,
      required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              image1,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kH1Text.copyWith(color: Colors.black54),
                ),
                Text(breed),
                Text(age)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
