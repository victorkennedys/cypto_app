import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:woof/screens/add_dog.dart';

class AddImageOfDog extends StatefulWidget {
  final double height;
  final double width;
  final List urlList;
  int imagesAdded = 0;

  AddImageOfDog(this.height, this.width, this.urlList);

  @override
  State<AddImageOfDog> createState() => _AddImageOfDogState();
}

class _AddImageOfDogState extends State<AddImageOfDog> {
  File? imageFile;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      setState(() {
        this.imageFile = imageTemporary;
      });
      uploadImageToFirebase(context);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future uploadImageToFirebase(context) async {
    String fileName = basename(imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    uploadTask.whenComplete(() async {
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      urlList.add(imageUrl);
      print(urlList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(horizontal: 3),
          height: widget.height,
          width: widget.width,
          child: imageFile != null
              ? Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  Icons.image,
                  color: Colors.white,
                )),
    );
  }
}
