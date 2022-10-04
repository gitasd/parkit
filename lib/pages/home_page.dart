// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_maps/google_maps_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//   @override
//   _HomePageState get createState => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   StreamSubscription? _locationSubscription;
//   Location _locationTracker = Location();
//   Marker? marker;
//   Circle? circle;
//   GoogleMapController? _controller;

//   static final CameraPosition initialLocation = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   Future<Uint8List> getMarker() async {
//     ByteData byteData =
//         await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
//     return byteData.buffer.asUint8List();
//   }

//   void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
//     LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
//     this.setState(() {
//       marker = Marker(
//           markerId: MarkerId("home"),
//           position: latlng,
//           rotation: newLocalData.heading!,
//           draggable: false,
//           zIndex: 2,
//           flat: true,
//           anchor: Offset(0.5, 0.5),
//           icon: BitmapDescriptor.fromBytes(imageData));
//       circle = Circle(
//           circleId: CircleId("car"),
//           radius: newLocalData.accuracy!,
//           zIndex: 1,
//           strokeColor: Colors.blue,
//           center: latlng,
//           fillColor: Colors.blue.withAlpha(70));
//     });
//   }

//   void getCurrentLocation() async {
//     try {
//       Uint8List imageData = await getMarker();
//       var location = await _locationTracker.getLocation();

//       updateMarkerAndCircle(location, imageData);

//       if (_locationSubscription != null) {
//         _locationSubscription?.cancel();
//       }

//       _locationSubscription =
//           _locationTracker.onLocationChanged.listen((newLocalData) {
//         if (_controller != null) {
//           _controller?.animateCamera(CameraUpdate.newCameraPosition(
//               new CameraPosition(
//                   bearing: 192.8334901395799,
//                   target:
//                       LatLng(newLocalData.latitude!, newLocalData.longitude!),
//                   tilt: 0,
//                   zoom: 18.00)));
//           updateMarkerAndCircle(newLocalData, imageData);
//         }
//       });
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         debugPrint("Permission Denied");
//       }
//     }
//   }

//   @override
//   void dispose() {
//     if (_locationSubscription != null) {
//       _locationSubscription?.cancel();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   foregroundColor: Colors.black,
//       //   elevation: 0,
//       //   leading: BackButton(
//       //     onPressed: () {},
//       //   ),
//       //   title: Text("Parkit"),
//       // ),
//       body: GoogleMap(
//           initialCameraPosition: initialLocation,
//           markers: Set.of((marker != null) ? [marker] : []),
//           circles: Set.of((circle != null) ? [circle] : []),
//           onMapCreated: (GoogleMapController controller) {
//             _controller = controller;
//           }),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.location_searching),
//         onPressed: () {
//           getCurrentLocation();
//         },
//       ),

//       // body: Center(child: Text("Hello There")),
//       // body: currentLocation == null
//       //     ? const Center(child: Text("Loading"))
//       //     : GoogleMap(
//       //         initialCameraPosition: CameraPosition(
//       //             target: LatLng(
//       //                 currentLocation!.latitude!, currentLocation!.longitude!),
//       //             zoom: 14.5),
//       //         markers: {
//       //             Marker(
//       //                 markerId: const MarkerId("currentlocation"),
//       //                 position: LatLng(currentLocation!.latitude!,
//       //                     currentLocation!.longitude!))
//       //           }),

//       bottomNavigationBar: BottomAppBar(
//         elevation: 0,

//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: IconButton(
//                   icon: Icon(
//                     Icons.home_outlined,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () {}),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: IconButton(
//                   icon: Icon(
//                     Icons.save_outlined,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () {}),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: IconButton(
//                   icon: Icon(
//                     Icons.notes_rounded,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () {}),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: IconButton(
//                   icon: Icon(
//                     Icons.person,
//                     color: Colors.grey,
//                   ),
//                   onPressed: () {}),
//             ),
//           ],
//         ),
//         // elevation: 9.0,
//         shape: CircularNotchedRectangle(),
//         color: Colors.white,
//         // notchMargin: 8.0,
//       ),
//       // bottomNavigationBar: NavigationBar(
//       //   backgroundColor: Colors.white,
//       //   destinations: [
//       //     NavigationDestination(
//       //         icon: Icon(Icons.home_outlined), label: "HOME"),
//       //     NavigationDestination(
//       //         icon: Icon(Icons.bookmark_outlined), label: "SAVED"),
//       //     NavigationDestination(
//       //         icon: Icon(Icons.notes_outlined), label: "BOOKINGS"),
//       //     NavigationDestination(
//       //         icon: Icon(Icons.man_outlined), label: "PROFILE")
//       //   ],
//       // )
//     );
//   }
// }
