import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:another_carousel_pro/another_carousel_pro.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parkit/constant.dart';
import 'package:parkit/pages/forget_password.dart';
import 'package:parkit/pages/parking_details.dart';
import 'package:parkit/pages/parking_search.dart';
import 'package:parkit/pages/saved.dart';
// import 'package:parkit/pages/db_manager/basket.dart';

class MapNew extends StatefulWidget {
  const MapNew({super.key});

  @override
  State<MapNew> createState() => _MapNewState();
}

class _MapNewState extends State<MapNew>
    with AutomaticKeepAliveClientMixin<MapNew> {
  Completer<GoogleMapController> _controller = Completer();

  late LatLng _initialPosition = LatLng(26.4496, 80.1927);
  BitmapDescriptor customCarIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor parkingIcon = BitmapDescriptor.defaultMarker;
  // Uint8List? customCarIcon;
  // Uint8List? parkingIcon;

  final Set<Marker> _markers = new Set();

  var locationsMap = {};
  var parkingNames = <dynamic>{};

  // method to get current location
  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  updateMarkers() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 3.2),
            "assets/images/parking-4.png")
        .then((parkicon) => {
              setState(
                () {
                  parkingIcon = parkicon;
                },
              )
            });
    // size: Size(50, 50)
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 3.2),
            "assets/images/car_icon.png")
        .then((caricon) => {
              setState(
                () {
                  customCarIcon = caricon;
                },
              )
            });
  }

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
  void initState() {
    getParkingLocations();
    liveLocationCameraMove();
    updateMarkers();
    super.initState();
  }

  getParkingLocations() async {
    // location = records
    var locations =
        await FirebaseFirestore.instance.collection('parkings').snapshots();
    locations.forEach((element) {
      element.docs.forEach((temp) {
        setState(() {
          parkingNames.add(temp.data()['location']);
          locationsMap[temp.data()['location']] = [
            temp.data()['latitude'],
            temp.data()['longitude']
          ];
        });
      });
    });
  }

  moveCamera(CameraPosition newPostion) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPostion));
    setState(() {});
  }

  liveLocationCameraMove() async {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());

      // marker added for current users location
      _markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(value.latitude, value.longitude),
          rotation: value.heading,
          infoWindow: InfoWindow(
            title: 'My Current Location',
          ),
          icon: customCarIcon,
        ),
      );

      // specified current users location
      CameraPosition cameraPosition = new CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 18.5,
      );
      moveCamera(cameraPosition);
    });
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
              onPressed: () async {
                var searchedLoction = await showSearch(
                    context: context,
                    delegate: SearchParking(locationslist: parkingNames));

                if (searchedLoction != '') {
                  var lat =
                      double.parse(locationsMap[searchedLoction.toString()][0]);
                  var lng =
                      double.parse(locationsMap[searchedLoction.toString()][1]);
                  CameraPosition newPosition = new CameraPosition(
                    target: LatLng(lat, lng),
                    zoom: 18.5,
                  );
                  moveCamera(newPosition);
                }
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        child: GoogleMap(
          // on below line setting camera position
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(_initialPosition.latitude, _initialPosition.longitude),
              zoom: 14.47),
          myLocationButtonEnabled: true,
          markers: getmarkers(),
          // markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
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
            _markers.add(Marker(
              markerId: MarkerId("1"),
              position: LatLng(value.latitude, value.longitude),
              rotation: value.heading,
              infoWindow: InfoWindow(
                title: 'My Current Location',
              ),
              icon: customCarIcon,
            ));

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 18.5,
            );
            moveCamera(cameraPosition);
          });
        },
        child: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  Set<Marker> getmarkers() {
    setState(() {
      locationsMap.forEach((key, value) {
        _markers.add(Marker(
            markerId: MarkerId(key),
            position: LatLng(double.parse(value[0]), double.parse(value[1])),
            infoWindow: InfoWindow(
              title: key,
            ),
            onTap: () {
              String _parkingToBeSaved;
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(
                          color: Colors.grey.withOpacity(0.5),
                          thickness: 3,
                          indent: MediaQuery.of(context).size.width * 0.4,
                          endIndent: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Text("Details",
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Divider(
                          color: Colors.grey,
                          indent: MediaQuery.of(context).size.width * 0.05,
                          endIndent: MediaQuery.of(context).size.width * 0.05,
                        ),
                        const Spacer(),
                        Container(
                          height: 200.0,
                          // color: primaryColour,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Carousel(
                            dotColor: primaryColour,
                            dotIncreasedColor: primaryColour,
                            borderRadius: true,
                            dotSize: 6.0,
                            dotSpacing: 17.0,
                            dotBgColor: Colors.transparent,
                            radius: Radius.circular(30.0),
                            boxFit: BoxFit.fitWidth,
                            images: [
                              AssetImage("assets/images/parking_lot_demo.jpg"),
                              AssetImage("assets/images/parking_lot_demo.jpg"),
                              AssetImage("assets/images/login_banner.png"),
                              AssetImage("assets/images/parking_lot_demo.jpg"),
                            ],
                            indicatorBgPadding: 15.0,
                            autoplay: false,
                            animationCurve: Curves.fastOutSlowIn,
                            animationDuration: Duration(milliseconds: 1000),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  key,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "151 K, Kanpur Dehat, PSIT",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  _parkingToBeSaved = key;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SavedParkingLots(
                                                parkingTobeSaved:
                                                    _parkingToBeSaved,
                                              )));
                                },
                                icon: Icon(
                                  Icons.bookmark_outline,
                                  color: primaryColour,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      60)),
                                  maximumSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      60)),
                                  backgroundColor: MaterialStateProperty.all(
                                      lightPrimaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all(primaryColour),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: lightPrimaryColor)))),
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ParkingDetails()));
                                },
                                child: Text("Details ➜"),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      60)),
                                  maximumSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      60)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff2756FF)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: primaryColour))),
                                )),
                            const Spacer(),
                          ],
                        ),
                        const Spacer()
                      ],
                    );
                  });
            },
            // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
            icon: parkingIcon));
      });
    });
    // setState(() {
    //   _markers.add(Marker(
    //       markerId: MarkerId("2"),
    //       position: LatLng(26.4733, 80.3528),
    //       infoWindow: InfoWindow(
    //         title: 'Z square',
    //       ),
    //       icon: BitmapDescriptor.fromBytes(parkingIcon!)));
    //   _markers.add(Marker(
    //       markerId: MarkerId("3"),
    //       position: LatLng(26.450206, 80.193810),
    //       infoWindow: InfoWindow(
    //         title: 'PSIT parking 1',
    //       ),
    //       icon: BitmapDescriptor.fromBytes(parkingIcon!)));
    //   _markers.add(Marker(
    //       markerId: MarkerId("4"),
    //       position: LatLng(26.452980, 80.193817),
    //       infoWindow: InfoWindow(
    //         title: 'PSIT parking 2',
    //       ),
    //       icon: BitmapDescriptor.fromBytes(parkingIcon!)));
    //   _markers.add(Marker(
    //       markerId: MarkerId("5"),
    //       position: LatLng(26.452980, 80.193817),
    //       infoWindow: InfoWindow(
    //         title: 'PSIT parking 3',
    //       ),
    //       icon: BitmapDescriptor.fromBytes(parkingIcon!)));

    //   _markers.add(Marker(
    //       markerId: MarkerId("6"),
    //       position: LatLng(26.450951, 80.192701),
    //       infoWindow: InfoWindow(
    //         title: 'PSIT parking 4',
    //       ),
    //       icon: BitmapDescriptor.fromBytes(parkingIcon!)));

    //   _markers.add(Marker(
    //       markerId: MarkerId("7"),
    //       position: LatLng(26.449654, 80.191338),
    //       infoWindow: InfoWindow(
    //         title: 'PSIT parking 5',
    //       ),
    //       icon: BitmapDescriptor.fromBytes(parkingIcon!)));
    // });
    return _markers;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
