import 'package:flutter/material.dart';
import 'package:woof/screens/dog/add_dog.dart';

class AddDogWidget extends StatefulWidget {
  Map dogData = {};
  @override
  State<AddDogWidget> createState() => _AddDogWidgetState();
}

class _AddDogWidgetState extends State<AddDogWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.dogData = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDogScreen(),
          ),
        );
        setState(() {
          widget.dogData;
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
