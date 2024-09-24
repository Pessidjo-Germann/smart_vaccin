import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Package pour le carousel
// Import de la page de connexion

class ParentHomeScreen extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/carousel1.jpeg',
    'assets/images/carousel2.jpeg',
    'assets/images/carousel3.jpeg',
    'assets/images/carousel4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo 1.jpg', // Chemin vers le logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Smart Vaccin'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          // Texte de bienvenue
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Bienvenue dans votre espace de gestion de la santé de votre enfant',
              style: TextStyle(
                fontSize: isLargeScreen ? 24 : 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                //textAlign: TextAlign.center, // Centrage du texte de bienvenue
              ),
            ),
          ),
          SizedBox(height: 20),
          // Texte défilant de sensibilisation
          Container(
            width: double.infinity,
            height: 50,
            child: Marquee(
              text:
              'La vaccination infantile sauve des vies ! Protégez votre enfant contre les maladies évitables grâce à la vaccination. La vaccination est essentielle pour un avenir sain et sûr.',
              style: TextStyle(
                fontSize: isLargeScreen ? 20 : 16,
                color: Colors.blue, // Texte en bleu
                fontWeight: FontWeight.bold,
              ),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 100.0,
              velocity: 100.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          Spacer(),
          // Bouton d'accès à l'espace parent
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: isLargeScreen ? screenWidth * 0.4 : screenWidth * 0.8, // Largeur réduite
              height: 70, // Hauteur augmentée du bouton
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _LoginScreenState()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Bordure arrondie
                  ),
                ),
                child: Text(
                  'Accéder à l\'espace parent',
                  style: TextStyle(
                    fontSize: isLargeScreen ? 20 : 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Carousel d'images défilantes sous le bouton
          CarouselSlider(
            options: CarouselOptions(
              height: isLargeScreen ? 300 : 200, // Hauteur ajustée selon la taille de l'écran
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              scrollDirection: Axis.horizontal, // Défilement horizontal
            ),
            items: imgList.map((item) => Container(
              child: Center(
                child: Image.asset(item, fit: BoxFit.cover, width: 1000),
              ),
            )).toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Marquee({required String text, required TextStyle style, required Axis scrollAxis, required CrossAxisAlignment crossAxisAlignment, required double blankSpace, required double velocity, required Duration pauseAfterRound, required double startPadding, required Duration accelerationDuration, required Curve accelerationCurve, required Duration decelerationDuration, required Cubic decelerationCurve}) {}

  _LoginScreenState() {}
}
