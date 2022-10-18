import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkit/constant.dart';
import 'package:parkit/pages/parking_search.dart';

class MapNew extends StatefulWidget {
  const MapNew({super.key});

  @override
  State<MapNew> createState() => _MapNewState();
}

class _MapNewState extends State<MapNew>
    with AutomaticKeepAliveClientMixin<MapNew> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );
  final Set<Marker> _markers = new Set();

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text("Search Parking..."),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchParking());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        child: GoogleMap(
          // on below line setting camera position
          initialCameraPosition: _kGoogle,
          // on below line we are setting markers on the map
          markers: getmarkers(), //Set<Marker>.of(_markers),
          // on below line specifying map type.
          mapType: MapType.normal,
          // on below line setting user location enabled.
          myLocationEnabled: true,
          // on below line setting compass enabled.
          compassEnabled: true,
          // on below line specifying controller on map complete.
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),

      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff643B9F),
        foregroundColor: Colors.white,
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());

            // marker added for current users location
            _markers.add(
              Marker(
                markerId: MarkerId("1"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              ),
            );

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 18.5,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  Set<Marker> getmarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("2"),
        position: LatLng(26.4733, 80.3528),
        infoWindow: InfoWindow(
          title: 'Z square',
        ),
      ));
      _markers.add(Marker(
        markerId: MarkerId("3"),
        position: LatLng(26.450206, 80.193810),
        infoWindow: InfoWindow(
          title: 'PSIT parking 1',
        ),
      ));
      _markers.add(Marker(
        markerId: MarkerId("4"),
        position: LatLng(26.452980, 80.193817),
        infoWindow: InfoWindow(
          title: 'PSIT parking 2',
        ),
      ));
      _markers.add(Marker(
        markerId: MarkerId("5"),
        position: LatLng(26.452980, 80.193817),
        infoWindow: InfoWindow(
          title: 'PSIT parking 3',
        ),
      ));

      _markers.add(Marker(
        markerId: MarkerId("6"),
        position: LatLng(26.450951, 80.192701),
        infoWindow: InfoWindow(
          title: 'PSIT parking 4',
        ),
      ));

      _markers.add(Marker(
        markerId: MarkerId("7"),
        position: LatLng(26.449654, 80.191338),
        infoWindow: InfoWindow(
          title: 'PSIT parking 5',
        ),
      ));
    });
    return _markers;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
