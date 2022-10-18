import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition:
            CameraPosition(target: LatLng(26.4496, 80.1927), zoom: 14),
      ),
    );
  }
}
