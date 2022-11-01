import 'package:firebase_core/firebase_core.dart';
import 'package:parkit/pages/fill_details.dart';
import 'package:parkit/pages/forget_password.dart';
import 'package:parkit/pages/landing_page.dart';
import 'package:parkit/pages/login_page.dart';
import 'package:parkit/pages/hero_page.dart';
import 'package:parkit/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkit/pages/parking_details.dart';
import 'package:parkit/pages/qr.dart';
import 'package:parkit/pages/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins(
            fontSize: 30,
          ).fontFamily,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // initialRoute: '/forgotpass',
      // routes: {
      //   "/forgotpass": (context) => HomePage(),
      // },
      initialRoute: '/fill_details',
      // initialRoute:
      //     initScreen == 0 || initScreen == null ? '/onboard' : '/home',
      routes: {
        "/onboard": (context) => OnBoardingScreen(),
        "/login": (context) => LoginPage(),
        "/parking_details": (context) => ParkingDetails(),
        "/landing_page": (context) => LandingPage(),
        "/check_live_location": (context) => MapNew(),
        "/transaction": (context) => Transaction(),
        "/qr": (context) => Qrcode(),
        "/fill_details": (context) => FillDetails()
      },
    );
  }
}
