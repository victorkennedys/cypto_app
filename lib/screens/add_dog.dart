import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import '../components/form_question_text.dart';
import '../constants.dart';

class AddDogScreen extends StatelessWidget {
  static const String id = 'add_dog_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlackPinkText(
            blackText: "Lägg till din",
            pinkText: "hund",
            bottomPaddingHigh: true,
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              elevation: 8.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormQuestionText("Ladda upp en bild på din hund"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddImageOfDog(100, 100),
                          AddImageOfDog(70, 70),
                          AddImageOfDog(70, 70),
                        ],
                      ),
                    ),
                    FormQuestionText("Vad heter din hund?"),
                    TextField(
                      decoration: kInputDecoration.copyWith(
                          hintText: "Vad heter din hund?"),
                    )
                  ],
                ),
              ),
            ),
          ),
          AppButton(
              buttonColor: kPurpleColor,
              textColor: kPinkColor,
              onPressed: () {},
              buttonText: "Klar")
        ],
      ),
    );
  }
}

class AddImageOfDog extends StatefulWidget {
  final double height;
  final double width;

  AddImageOfDog(this.height, this.width);

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
      uploadToFireBase(context);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future uploadToFireBase(context) async {
    String fileName = basename(imageFile!.path);

    Reference ref = FirebaseStorage.instance.ref().child('dogimages/$fileName');
    var uploadTask = ref.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    print(url);
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
              ? Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.image,
                  color: Colors.white,
                )),
    );
  }
}
