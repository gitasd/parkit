import 'package:flutter/material.dart';
import 'package:parkit/constant.dart';
import 'package:parkit/pages/booking.dart';
import 'package:parkit/pages/hero_page.dart';
import 'package:parkit/pages/profile.dart';
import 'package:parkit/pages/saved.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController pageController = PageController();
  int _index = 0;

  List<Widget> pages = [
    MapNew(),
    SavedParkingLots(
      parkingTobeSaved: '',
    ),
    Bookings(),
    Profile()
  ];
  // List pages = [homepage, savedparking, booking, profile];

  void onPageChanged(int index) {
    setState(() {
      _index = index;
    });
  }

  void onItemTap(int index) {
    setState(() {
      _index = index;
    });
    pageController.jumpToPage(_index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTap,
          iconSize: 25,
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          selectedItemColor: primaryColour,
          unselectedItemColor: Colors.grey.withOpacity(0.9),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline), label: "Saved"),
            BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Booking"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );
  }
}
