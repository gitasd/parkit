import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps/google_maps_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _completer = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   elevation: 0,
      //   leading: BackButton(
      //     onPressed: () {},
      //   ),
      //   title: Text("Parkit"),
      // ),
      // body: Center(child: Text("Hello There")),
      body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: sourceLocation, zoom: 14.5)),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,

        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  icon: Icon(
                    Icons.save_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  icon: Icon(
                    Icons.notes_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  onPressed: () {}),
            ),
          ],
        ),
        // elevation: 9.0,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        // notchMargin: 8.0,
      ),
      // bottomNavigationBar: NavigationBar(
      //   backgroundColor: Colors.white,
      //   destinations: [
      //     NavigationDestination(
      //         icon: Icon(Icons.home_outlined), label: "HOME"),
      //     NavigationDestination(
      //         icon: Icon(Icons.bookmark_outlined), label: "SAVED"),
      //     NavigationDestination(
      //         icon: Icon(Icons.notes_outlined), label: "BOOKINGS"),
      //     NavigationDestination(
      //         icon: Icon(Icons.man_outlined), label: "PROFILE")
      //   ],
      // )
    );
  }
}
