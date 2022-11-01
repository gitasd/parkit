import 'package:parkit/constant.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    "Forgot Password",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Image.asset("assets/images/login_banner.png", fit: BoxFit.cover),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                  "Select which contact details should we use to reset your password"),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 500.0,
                height: 70.0,
                child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.message_sharp,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    onPressed: () {
                      print("VIA SMS");
                    },
                    // ignore: sort_child_properties_last
                    label: const Text(
                      "via SMS",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white,
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 500.0,
                height: 70.0,
                child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.message_sharp,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    onPressed: () {
                      print("VIA EMAIL");
                    },
                    // ignore: sort_child_properties_last
                    label: const Text(
                      "via EMAIL",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white,
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/forget_pass1");
                },
                // ignore: sort_child_properties_last
                child: const Text("Continue"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  shape: const StadiumBorder(),
                  backgroundColor: primaryColour,
                  minimumSize: const Size.fromHeight(50.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}













































// Scaffold(
//           backgroundColor:Colors.white ,
//           appBar: AppBar(
//             backgroundColor:Colors.white ,
//             elevation:0,
//             leading:
//               IconButton( 
//                 icon:const Icon(Icons.arrow_back,color:Colors.black) ,
//                 onPressed: () { print("hiii");},
//                 ),
            
//             title: const Text(
//               "Forgot Password",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         body: Container(),
//         ),