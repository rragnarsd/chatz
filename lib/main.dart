import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chatz/screens/landing_screen/landing_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 153, 204, 174),
        statusBarBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.sarabunTextTheme()),
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
