import 'package:assaman/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: OnboardingScreen()
        ),
      ),
    );
  }
}
