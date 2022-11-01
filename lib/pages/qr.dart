import 'package:image_picker/image_picker.dart';
import 'package:parkit/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class Qrcode extends StatefulWidget {
  const Qrcode({super.key});

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Parking Ticket'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        QrImage(
          data: 'parking 1',
          version: QrVersions.auto,
          size: 200,
          gapless: false,
        ),
        Container(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 40.0),
                child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: const Text("Name",
                                style: TextStyle(
                                  color: Colors.grey,
                                ))),
                        Container(
                            child: Text("Vehicle",
                                style: TextStyle(
                                  color: Colors.grey,
                                )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text("ANZ")),
                        Container(child: Text("Mahindra XUV-500"))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text("Parking Area",
                                style: TextStyle(
                                  color: Colors.grey,
                                ))),
                        Container(
                            child: Text("Parking Spot",
                                style: TextStyle(
                                  color: Colors.grey,
                                )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text("PSIT parking 1")),
                        Container(child: Text("A05"))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text("Duration",
                                style: TextStyle(
                                  color: Colors.grey,
                                ))),
                        Container(
                            child: Text("Date",
                                style: TextStyle(
                                  color: Colors.grey,
                                )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text("4hours")),
                        Container(child: Text("October 16, 2022"))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text("Hours",
                                style: TextStyle(
                                  color: Colors.grey,
                                ))),
                        Container(
                            child: Text("Phone",
                                style: TextStyle(
                                  color: Colors.grey,
                                )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text("09 AM - 13 PM")),
                        Container(child: Text("+91 9956644554"))
                      ],
                    ),
                  ],
                ))),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/create_new_pass");
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.90, 50)),
                maximumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.90, 50)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Color(0xff2756FF)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff2756FF))))),
            // style: ElevatedButton.styleFrom(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: 40.0, vertical: 20.0),
            //   shape: const StadiumBorder(),
            //   backgroundColor: const Color(0xff2756FF),
            //   minimumSize: const Size.fromHeight(50.0),

            child: const Text("Navigate to Parking Lot")),
      ]),
    );
  }
}
