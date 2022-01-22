import 'package:flutter/material.dart';
import 'package:woof/constants.dart';
import 'package:woof/models/dog_owner_model.dart';
import 'package:woof/screens/adverts/dashboard.dart';
import 'package:woof/screens/chat/chat_screen.dart';
import 'package:woof/screens/dog/my_dogs.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:woof/screens/profile_screen.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  NavBar(this.currentIndex);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: FluidNavBar(
          scaleFactor: 2,
          defaultIndex: widget.currentIndex,
          onChange: (value) async {
            if (value != widget.currentIndex) {
              if (value == 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              } else if (value == 1) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyDogs()),
                    (route) => false);
              } else if (value == 2) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AdvertsScreen()),
                    (route) => false);
              } else if (value == 3) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                    (route) => false);
              } else if (value == 4) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                    (route) => false);
              }
            }
          },
          icons: [
            FluidNavBarIcon(
              selectedForegroundColor: kPurpleColor,
              icon: Icons.home,
              backgroundColor: Colors.white,
            ),
            FluidNavBarIcon(
              selectedForegroundColor: kPinkColor,
              icon: Icons.pets,
              backgroundColor: Colors.white,
            ),
            FluidNavBarIcon(
              selectedForegroundColor: kPinkColor,
              icon: Icons.dashboard,
              backgroundColor: Colors.white,
            ),
            FluidNavBarIcon(
              selectedForegroundColor: kPinkColor,
              icon: Icons.chat,
              backgroundColor: Colors.white,
            ),
            FluidNavBarIcon(
              selectedForegroundColor: kPinkColor,
              icon: Icons.account_circle,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
