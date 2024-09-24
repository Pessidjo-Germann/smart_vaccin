import 'package:flutter/material.dart';

class MedicalDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo 2.jpg', // Logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Tableau de Bord - Personnel Médical'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Nombre de colonnes
          crossAxisSpacing: 10, // Espacement entre les colonnes
          mainAxisSpacing: 10, // Espacement entre les lignes
          children: [
            // Bouton Gérer les vaccinations
            _buildDashboardButton(
              context,
              'assets/images/vaccination.png', // Image à afficher
              'Gérer les vaccinations',
                  () {
                Navigator.pushNamed(context, '/vaccination-management'); // Redirige vers l'écran de gestion des vaccinations
              },
            ),
            // Bouton Gérer les stocks de vaccins
            _buildDashboardButton(
              context,
              'assets/images/vaccine_stock.png', // Image à afficher
              'Gérer les stocks de vaccins',
                  () {
                Navigator.pushNamed(context, '/vaccine-stock-dashboard'); // Redirige vers le tableau de bord des stocks
              },
            ),
            // Bouton Planifier les campagnes de vaccination
            _buildDashboardButton(
              context,
              'assets/images/campaign.png', // Image à afficher
              'Planifier des campagnes',
                  () {
                Navigator.pushNamed(context, '/campaign-management'); // Redirige vers l'écran de gestion des campagnes
              },
            ),
            // Bouton Consulter les statistiques
            _buildDashboardButton(
              context,
              'assets/images/statistics.png', // Image à afficher
              'Consulter les statistiques',
                  () {
                Navigator.pushNamed(context, '/statistics'); // Redirige vers l'écran des statistiques
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer les boutons du tableau de bord
  Widget _buildDashboardButton(BuildContext context, String imagePath, String title, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath, // Affiche l'image
              height: 80, // Hauteur de l'image
            ),
            SizedBox(height: 10),
            Text(
              title, // Affiche le texte sous l'image
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
