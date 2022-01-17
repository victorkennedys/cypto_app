import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/screens/dog/add_dog_image.dart';

class AddDogWidget extends StatefulWidget {
  final Function setDocId;
  AddDogWidget(this.setDocId);
  Map dogData = {};
  static const String id = 'add_dog_widget';
  final _auth = FirebaseAuth.instance;
  late User loggedInUser = _auth.currentUser!;
  @override
  State<AddDogWidget> createState() => _AddDogWidgetState();
}

class _AddDogWidgetState extends State<AddDogWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Map<String, dynamic>? data = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddDogImage(),
          ),
        );
        print(data);

        widget.setDocId(data!['docId']);
        setState(() {
          widget.dogData = data;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black45, width: 1),
          ),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  child: widget.dogData.isEmpty
                      ? Image.asset('images/dog.png')
                      : Image.network(
                          widget.dogData['imageUrl'],
                        ),
                ),
              ),
              Flexible(
                child: Text(widget.dogData.isEmpty
                    ? "Lägg till din hund"
                    : widget.dogData['dogName']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
