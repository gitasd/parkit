import 'package:parkit/pages/forget_password.dart';
import 'package:parkit/pages/home_page.dart';
import 'package:parkit/pages/login_page.dart';
import 'package:parkit/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins(
            fontSize: 30,
          ).fontFamily,
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/forgotpass',
      routes: {
        "/forgotpass": (context) => HomePage(),
      },
      // initialRoute:
      //     initScreen == 0 || initScreen == null ? '/onboard' : '/home',
      // routes: {
      //   "/onboard": (context) => OnBoardingScreen(),
      //   "/home": (context) => HomePage(),
      //   "/login": (context) => LoginPage(),
      // },
    );
  }
}
