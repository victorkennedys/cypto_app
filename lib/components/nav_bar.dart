import 'package:flutter/material.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:woof/screens/my_dogs.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  NavBar(this.currentIndex);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      unselectedIconTheme: IconThemeData(color: kPinkColor),
      unselectedLabelStyle: TextStyle(color: kPurpleColor),
      selectedLabelStyle: TextStyle(color: kPurpleColor),
      onTap: (value) {
        if (value != widget.currentIndex) {
          if (value == 0) {
            Navigator.pushNamed(context, Home.id);
          } else if (value == 1) {
            Navigator.pushNamed(context, MyDogs.id);
          } else if (value == 2) {
            Navigator.pushNamed(context, Home.id);
          } else if (value == 3) {
            //Link to dashboard
          } else if (value == 4) {
            //Link to profile screen
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          label: "Hem",
          icon: Icon(
            Icons.home,
            color: kPurpleColor,
          ),
        ),
        BottomNavigationBarItem(
          label: "hundar",
          icon: Icon(
            Icons.pets,
            color: kPurpleColor,
          ),
        ),
        BottomNavigationBarItem(
          label: "Få hjälp",
          icon: Icon(
            Icons.add,
            color: kPurpleColor,
          ),
        ),
        BottomNavigationBarItem(
          label: "Mina hundar",
          icon: Icon(
            Icons.dashboard,
            color: kPurpleColor,
          ),
        ),
        BottomNavigationBarItem(
          label: "Profil",
          icon: Icon(
            Icons.account_box,
            color: kPurpleColor,
          ),
        ),
      ],
    );
  }
}
