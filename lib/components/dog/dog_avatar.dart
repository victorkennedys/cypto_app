import 'package:flutter/material.dart';

class DogAvatar extends StatelessWidget {
  final String imageUrl;

  const DogAvatar(this.imageUrl, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height / 17,
        width: MediaQuery.of(context).size.height / 17,
      ),
    );
  }
}
