import 'package:flutter/material.dart';

class ParentHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo 1.jpg', // Chemin vers le logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Smart Vaccin - Espace Parent'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tableau de Bord',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Deux colonnes pour le tableau de bord
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // Bouton pour ajouter un enfant
                  DashboardItem(
                    imagePath: 'assets/images/Child.png',
                    label: 'Ajouter un enfant',
                    onTap: () {
                      // Redirection vers l'écran d'ajout d'enfant
                    },
                  ),
                  // Bouton pour consulter le calendrier vaccinal
                  DashboardItem(
                    imagePath: 'assets/images/calender.png',
                    label: 'Calendrier vaccinal',
                    onTap: () {
                      // Redirection vers l'écran du calendrier vaccinal
                    },
                  ),
                  // Bouton pour consulter les paramètres / rappels
                  DashboardItem(
                    imagePath: 'assets/images/reminder.png',
                    label: 'Paramètres / Rappels',
                    onTap: () {
                      // Redirection vers les paramètres ou rappels de vaccination
                    },
                  ),
                  // Exemple d'autres boutons
                  DashboardItem(
                    imagePath: 'assets/images/vaccine.png',
                    label: 'Certificats',
                    onTap: () {
                      // Redirection vers les certificats de vaccination
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget réutilisable pour chaque élément du tableau de bord
class DashboardItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  DashboardItem({required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 80,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
