import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageModel {
  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      return imageTemporary;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future imageFromGallery() async {
    try {
      await Permission.camera.request();
      final XFile? xfile =
          await ImagePicker().pickVideo(source: ImageSource.camera);
      if (xfile == null) {
        throw Exception('no file');
      }
      final videoTemprary = File(xfile.path);
      return videoTemprary;
    } catch (e) {
      throw Exception(e);
    }
  }
}
