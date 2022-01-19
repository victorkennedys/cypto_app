import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/image_picker.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';

class CreateHelperProfileScreen extends StatelessWidget {
  Map<String, dynamic> data = {};
  getDescriptionInput(String input) {
    data.addAll({"description": input});
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: FormQuestionText("Skriv en text om dig själv  *")),
                  Container(
                    child: TextField(
                      maxLines: 6,
                      maxLength: 600,
                      keyboardType: TextInputType.multiline,
                      enabled: true,
                      decoration: kInputDecoration.copyWith(
                          hintText: "Berätta om dig själv",
                          hintStyle: TextStyle(
                            fontSize: 14,
                          )),
                      onChanged: (value) {
                        getDescriptionInput(value);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
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
                            children: [
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
                              )),
                            ]),
                      ),
                    ),
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
