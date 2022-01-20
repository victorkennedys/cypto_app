import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/walker%20onboarding/walker_info.dart';

class IdVerificationScreen extends StatelessWidget {
  Future<void> onfido() async {
    try {} catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IdImagePicker(data, "front"),
          IdImagePicker(data, "back"),
          AppButton(
              buttonColor: kPurpleColor,
              textColor: kPinkColor,
              onPressed: () {
                Navigator.pop(context, data);
              },
              buttonText: 'verifiera')
        ],
      ),
    );
  }
}

class IdImagePicker extends StatefulWidget {
  final Map<String, dynamic> dataMap;
  final String frontOrBack;
  IdImagePicker(this.dataMap, this.frontOrBack);
  @override
  State<IdImagePicker> createState() => _IdImagePickerState();
}

class _IdImagePickerState extends State<IdImagePicker> {
  File? imageFile;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
      uploadImageToFirebase(context);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future uploadImageToFirebase(context) async {
    String fileName = basename(imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    uploadTask.whenComplete(() async {
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      dataMap.addAll({"${widget.frontOrBack}": imageUrl});
      print(dataMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(),
      child: ClipOval(
        child: Container(
          decoration:
              BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 100,
          width: 100,
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
