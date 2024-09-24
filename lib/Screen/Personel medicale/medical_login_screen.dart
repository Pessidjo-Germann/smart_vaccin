import 'dart:io'; // Pour vérifier que la plateforme est Windows
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalLoginScreen extends StatefulWidget {
  @override
  _MedicalLoginScreenState createState() => _MedicalLoginScreenState();
}

class _MedicalLoginScreenState extends State<MedicalLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  // Fonction pour gérer la connexion
  void _login() async {
    // Exemple de vérification des informations de connexion
    if (_usernameController.text == 'admin' && _passwordController.text == '1234') {
      // Stocker l'état de connexion
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Naviguer vers l'écran d'accueil du personnel médical
      Navigator.pushReplacementNamed(context, '/medical-home');
    } else {
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nom d\'utilisateur ou mot de passe incorrect'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Vérifier si l'application s'exécute sur Windows
    if (!Platform.isWindows) {
      return Scaffold(
        body: Center(
          child: Text(
            'Cette application est disponible uniquement sous Windows.',
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
              'assets/images/logo 2.jpg', // Logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Connexion - Personnel Médical'),
          ],
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Colonne gauche : Formulaire de connexion
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Se connecter'),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20), // Espacement entre les colonnes

            // Colonne droite : Description des fonctionnalités
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fonctionnalités disponibles pour le personnel médical',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '- Gérer les vaccinations des enfants\n'
                        '- Gérer les stocks de vaccins\n'
                        '- Planifier des campagnes de vaccination\n'
                        '- Consulter les statistiques de vaccination',
                    style: TextStyle(fontSize: 18),
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
