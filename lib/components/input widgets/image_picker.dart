import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woof/models/add_to_firestore.dart';

class PickImage extends StatefulWidget {
  final double height;
  final double width;
  final List urlList;
  final bool rounded;

  const PickImage(this.height, this.width, this.urlList, this.rounded,
      {Key? key})
      : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? imageFile;
  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
      String url = await AddToFireStore().addFileToFireStore(imageFile);

      widget.urlList.add(url);
      print(widget.urlList);
    } on PlatformException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(context),
      child: ClipOval(
        child: Container(
          decoration:
              BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: widget.height,
          width: widget.width,
          child: imageFile != null
              ? Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  child: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
