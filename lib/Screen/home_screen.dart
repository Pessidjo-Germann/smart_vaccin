import 'dart:io'; // Pour vérifier que la plateforme est Windows
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  // Contrôleurs pour les champs de saisie
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Charger les données existantes ici (ex : depuis Firebase)
    // _loadUserProfile();
  }

  // Fonction pour simuler le chargement des données utilisateur
  void _loadUserProfile() {
    // Ici, tu peux charger les données depuis Firebase ou Firestore
    // Exemple fictif :
    _nomController.text = 'MASSONOL';
    _prenomController.text = 'Georges Collins';
    _emailController.text = 'georgescollinm@gmail.com';
    _telephoneController.text = '691232863';
    _roleController.text = 'parent';
  }

  // Fonction pour sauvegarder les modifications du profil
  void _saveProfile() {
    // Sauvegarder les informations modifiées dans Firestore ou Firebase
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String email = _emailController.text;
    String telephone = _telephoneController.text;

    // Appeler une fonction de mise à jour (ex: dans Firestore)
    // updateUserProfile(nom, prenom, email, telephone);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Profil mis à jour avec succès'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Vérification si la plateforme est Windows
    if (!Platform.isWindows) {
      return Scaffold(
        body: Center(
          child: Text(
            'Cette application ne peut être exécutée que sous Windows.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo 1.jpg', // Chemin vers le logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Modifier le Profil'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Champ Nom
              TextField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Champ Prénom
              TextField(
                controller: _prenomController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Champ Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Champ Téléphone
              TextField(
                controller: _telephoneController,
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40),

              // Bouton Sauvegarder
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Sauvegarder',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
