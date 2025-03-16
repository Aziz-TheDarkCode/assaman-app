import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assaman/providers/theme_provider.dart';
import 'package:assaman/screens/onboarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: Color(0xFF1A5B9C),
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.light(
              primary: Color(0xFF1A5B9C),
              secondary: Color(0xFF4F8DCA),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: Color(0xFF4F8DCA),
            scaffoldBackgroundColor: Color(0xFF121212),
            textTheme: GoogleFonts.rubikTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
            ),
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF4F8DCA),
              secondary: Color(0xFF1A5B9C),
            ),
          ),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
        );
      },
    );
  }
}
