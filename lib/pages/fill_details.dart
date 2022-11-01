import 'dart:io';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:dropdown_button2/dropdown_button2.dart';

class FillDetails extends StatefulWidget {
  const FillDetails({Key? key}) : super(key: key);

  @override
  State<FillDetails> createState() => _FillDetailsState();
}

class _FillDetailsState extends State<FillDetails> {
  
  
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? valueChoose;
  final items = ['Male', 'Female', 'Transgender', 'Other'];
  final _auth = FirebaseAuth.instance;
  final nameEditingController = TextEditingController();
  final nickNameEditingController = TextEditingController();
  final dobFeildEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneNoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  "Fill Your Profile",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            imageProfile(context),
            const SizedBox(
              height: 20,
            ),
            nameTextField(context),
            const SizedBox(
              height: 20,
            ),
            nickName(context),
            const SizedBox(
              height: 20,
            ),
            dobField(context),
            const SizedBox(
              height: 20,
            ),
            email(context),
            const SizedBox(
              height: 20,
            ),
            phoneNo(context),
            const SizedBox(
              height: 20,
            ),
            gender(context),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  
                  Map<String, dynamic> data = {
                    'name': nameEditingController.text,
                    'nickName': nickNameEditingController.text,
                    'dob': dobFeildEditingController.text,
                    'email': emailEditingController.text,
                    'phoneNo': phoneNoEditingController.text,
                    'gender': valueChoose,
                  };

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(_auth.currentUser?.uid)
                      .set(data);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff2756FF),
                  minimumSize: const Size.fromHeight(50.0),
                ),
                child: const Text("Continue")),
          ],
        ),
      ),
    );
  }

  Widget imageProfile(context) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: getImage(),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(context)),
              );
            },
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xff2756FF),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet(context) {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "Choose profile photo",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: const Text("Camera"),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: const Text("Gallery"),
                ),
              ],
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  ImageProvider getImage() {
    if (_imageFile != null) {
      return FileImage(File(_imageFile!.path));
    }
    return const AssetImage("assets/images/profile_pic.png");
  }

  Widget nameTextField(context) {
    return TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot  be Empty");
        }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: "Name",
        // helperText: "Name can't be empty",
        hintText: "Your Good Name",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 12),
    );
  }

  Widget nickName(context) {
    return TextFormField(
      autofocus: false,
      controller: nickNameEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        nickNameEditingController.text = value!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: "Nickname",
        hintText: "What You being called at home.",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 12),
    );
  }

  Widget dobField(context) {
    return TextFormField(
      controller: dobFeildEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: 16,
          color: Color(0xff2756FF),
        ),
        labelText: "Date of Birth",
        helperText: "Dob can't be empty",
        hintText: "when you came on earth",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 12),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          print(pickedDate);
          String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
          print(formattedDate);
          setState(() {
            dobFeildEditingController.text = formattedDate;
          });
        } else {
          print("Select the date");
        }
      },
    );
  }

  Widget email(context) {
    return TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a Valid Email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          suffixIcon: const Icon(
            Icons.email_rounded,
            color: Color(0xff2756FF),
          ),
          labelText: "Email",
          hintText: "your online presence",
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 12));
  }

  Widget phoneNo(context) {
    return TextFormField(
        autofocus: false,
        controller: phoneNoEditingController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Phone Number cannot  be Empty");
          }
          return null;
        },
        onSaved: (value) {
          phoneNoEditingController.text = value!;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            suffixIcon: const Icon(
              Icons.phone,
              color: Color(0xff2756FF),
            ),
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            labelText: "Phone number",
            // helperText: "phone number can't be empty",
            hintText: "How one can contact you"),
        style: const TextStyle(color: Colors.black, fontSize: 12));
  }

  // ignore: non_constant_identifier_names
  Widget gender(context) {
    return DropdownButtonFormField2<String>(
      dropdownDecoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20)),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 30,
      iconEnabledColor: Color(0xff2756FF),
      buttonHeight: 30,
      buttonPadding: const EdgeInsets.only(left: 20, right: 5),
      isExpanded: true,
      style: const TextStyle(color: Colors.black, fontSize: 12),
      value: valueChoose,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.w600)
                      .fontFamily,
                )));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          valueChoose = newValue!;
        });
      },
      decoration: InputDecoration(
          isDense: true,
          // contentPadding: EdgeInsets.zero,
          hintText: "Select Gender",
          labelText: "Gender",
          labelStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}
