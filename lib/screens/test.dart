import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int progress = 0;
  Timer? _timer;

  List<String> messages = [
    "Nous téléchargeons les données…",
    "C’est presque fini…",
    "Plus que quelques secondes avant d’avoir le résultat…"
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (progress < 100) {
        setState(() {
          progress += 10;
        });
      } else {
        _timer?.cancel(); // Stop the timer once progress reaches 100%
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Ensure timer is canceled when the widget is destroyed
    super.dispose();
  }

  String getProgressMessage() {
    if (progress < 50) {
      return messages[0];
    } else if (progress < 90) {
      return messages[1];
    } else {
      return messages[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.shade100, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    value: progress / 100, // Updating progress dynamically
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF1A5B9C)),
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "$progress%",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  getProgressMessage(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
