import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddToFireStore {
  Future<String> addFileToFireStore(File? file) async {
    String url = '';
    String fileName = basename(file!.path);

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    await uploadTask.whenComplete(() async {
      String fileUrl = await firebaseStorageRef.getDownloadURL();
      url = fileUrl;
    });
    return url;
  }
}
