import 'package:flutter/material.dart';

class DogAvatar extends StatelessWidget {
  final String imageUrl;

  DogAvatar(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height / 17,
          width: MediaQuery.of(context).size.height / 17,
        ),
      ),
    );
  }
}
