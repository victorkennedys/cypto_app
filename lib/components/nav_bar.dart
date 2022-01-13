import 'package:flutter/material.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/adverts/dashboard.dart';
import 'package:woof/screens/dog/my_dogs.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:woof/screens/dog/add_dog.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

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
          onChange: (value) {
            if (value != widget.currentIndex) {
              if (value == 0) {
                Navigator.pushNamed(context, Home.id);
              } else if (value == 1) {
                Navigator.pushNamed(context, MyDogs.id);
              } else if (value == 2) {
                Navigator.pushNamed(context, AdvertsScreen.id);
              } else if (value == 3) {
                //Link to profile
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
              icon: Icons.account_circle,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
