import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/image_picker.dart';
import 'package:woof/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:woof/models/add_to_firestore.dart';

class CreateHelperProfileScreen extends StatelessWidget {
  Map<String, dynamic> data = {};

  getDescriptionInput(String input) {
    data.addAll({"description": input});
  }

  videoTap(BuildContext context) async {
    await Permission.camera.request();
    /*  Permission permission = await Permission.camera; */
    final XFile? video =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    if (video == null) {
      throw Exception('no video');
    } else {
      final videoTemprary = File(video.path);
      String url =
          await AddToFireStore().addVideoToFirebase(videoTemprary, context);
      data.addAll({'video': url});
    }
  }

  List<String> urlList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPinkColor,

                /* borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                ), */
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PickImage(
                        MediaQuery.of(context).size.height * 0.15,
                        MediaQuery.of(context).size.height * 0.15,
                        urlList,
                        true),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormQuestionText("Skriv en text om dig själv  *"),
                      TextField(
                        maxLines: 6,
                        maxLength: 600,
                        keyboardType: TextInputType.multiline,
                        enabled: true,
                        decoration: kInputDecoration.copyWith(
                          hintText: "Berätta om dig själv",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        onChanged: (value) {
                          getDescriptionInput(value);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          videoTap(context);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                        "Ladda upp en video där du berättar om dig själv"),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Icon(Icons.video_call),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: AppButton(
                        buttonColor: kPurpleColor,
                        textColor: kPinkColor,
                        onPressed: () {
                          Navigator.pop(context, data);
                        },
                        buttonText: 'Klar'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
