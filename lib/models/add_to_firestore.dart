import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddToFireStore {
  addVideoToFirebase(File? video, BuildContext context) {
    String fileName = basename(video!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('videos/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(video);
    uploadTask.whenComplete(() async {
      String videoUrl = await firebaseStorageRef.getDownloadURL();
      return videoUrl;
    });
  }
}
