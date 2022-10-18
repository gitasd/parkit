import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkit/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:parkit/pages/exapanded_widget.dart';

class ParkingDetails extends StatefulWidget {
  @override
  State<ParkingDetails> createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails> {
  List<String> imageAddr = [
    "assets/images/parking_lot_demo.jpg",
    "assets/images/parking_lot_demo.jpg",
    "assets/images/parking_lot_demo.jpg",
    "assets/images/parking_lot_demo.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(
          onPressed: () {},
        ),
        title: Text("Parking Details"),
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(
          height: 200.0,
          // color: primaryColour,
          width: MediaQuery.of(context).size.width * 0.8,
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
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Paking Lot of San Manolia",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "151 K, Kanpur Dehat, PSIT",
            style:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_pin,
                  ),
                  label: Text(
                    "2 km",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      minimumSize: MaterialStateProperty.all(Size(0, 50)),
                      maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.90, 50)),
                      foregroundColor:
                          MaterialStateProperty.all(Color(0xff2756FF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: primaryColour))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.timer,
                  ),
                  label: Text(
                    "8 AM - 10 PM",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      minimumSize: MaterialStateProperty.all(Size(0, 50)),
                      maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.90, 50)),
                      foregroundColor:
                          MaterialStateProperty.all(Color(0xff2756FF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: primaryColour))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Valet",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      minimumSize: MaterialStateProperty.all(Size(50, 50)),
                      maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.4, 50)),
                      foregroundColor:
                          MaterialStateProperty.all(Color(0xff2756FF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: primaryColour))))),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Description",
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          child: ExpandedTextWidget(
              text:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\₹8.00",
                  style: TextStyle(
                      color: primaryColour,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "per hour",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: lightPrimaryColor,
                borderRadius: BorderRadius.circular(10))),
        SizedBox(
          height: 100,
        )
      ]),
      bottomSheet: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Cancel"),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.45, 60)),
                  maximumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.45, 60)),
                  backgroundColor: MaterialStateProperty.all(lightPrimaryColor),
                  foregroundColor: MaterialStateProperty.all(primaryColour),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: lightPrimaryColor)))),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {},
                child: Text("Book Parking"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.45, 60)),
                  maximumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.45, 60)),
                  backgroundColor: MaterialStateProperty.all(Color(0xff2756FF)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: primaryColour))),
                )),
            const Spacer(),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            // bottomRight: Radius.circular(40.0),
            topLeft: Radius.circular(30.0),
            // bottomLeft: Radius.circular(40.0)
          ),
        ),
      ),
    );
  }
}

// Image.asset(
//           "assets/images/login_banner.png",
//           height: MediaQuery.of(context).size.width * 0.8,
//         ),
