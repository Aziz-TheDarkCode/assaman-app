import 'package:assaman/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/ornament.png'),
              fit: BoxFit.fitHeight,
              opacity: .3,
              alignment: Alignment.bottomLeft),
          gradient: LinearGradient(
            colors: [Colors.blueAccent.shade100, Colors.white],
            begin: Alignment.topLeft,
          )),
      child: Stack(
        children: [
          Positioned(
              top: 50,
              left: -80,
              child: SizedBox(
                width: 202,
                height: 202,
                child: Image.asset(
                  'assets/images/sun.png',
                  width: 2020,
                ),
              )),
          Positioned(
              bottom: 260,
              right: 0,
              child: SizedBox(
                width: 202,
                height: 202,
                child: Opacity(
                  opacity: 1,
                  child: Image.asset(
                    'assets/images/cloud.png',
                    width: double.infinity,
                    // opacity:,
                  ),
                ),
              )),
          Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avec Assaman ne soyez plus supris par le temps',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Gardez une longueur d'avance sur la météo grâce à nos prévisions précises",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4F5D75),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoadingScreen(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1A5B9C),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 32,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Lancer l'experience",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
