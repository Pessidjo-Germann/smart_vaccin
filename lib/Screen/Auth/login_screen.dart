// Pour vérifier la plateforme
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  int _loginAttempts = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fonction pour se connecter via Firebase
  void _login() async {
    if (_loginAttempts >= 3) {
      // Si 3 tentatives ont échoué, proposer de réinitialiser le mot de passe ou de s'inscrire
      _showResetOrSignupOptions();
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String userId = userCredential.user!.uid;

      // Récupérer le rôle de l'utilisateur depuis Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        String role = userDoc['role'];

        // Rediriger vers le tableau de bord approprié selon le rôle
        if (role == 'parent') {
          Navigator.pushReplacementNamed(context, '/parent-home');
        } else if (role == 'medical') {
          Navigator.pushReplacementNamed(context, '/medical-dashboard');
        } else if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin-dashboard');
        }
      }
    } catch (e) {
      _loginAttempts++;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur de connexion : ${e.toString()}'),
      ));
    }
  }

  // Fonction pour réinitialiser les options de mot de passe ou inscription après 3 échecs
  void _showResetOrSignupOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Réinitialiser le mot de passe ou s'inscrire"),
          content: Text("Vous avez échoué 3 fois. Que souhaitez-vous faire ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset-password'); // Rediriger vers la réinitialisation
              },
              child: Text('Réinitialiser le mot de passe'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Rediriger vers l'inscription
              },
              child: Text("S'inscrire"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade500, Colors.blue.shade900],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo de l'application
                  Image.asset(
                    'assets/images/logo g.jpg', // Chemin vers le logo
                    height: isLargeScreen ? 150 : 100, // Ajustement en fonction de l'écran
                  ),
                  SizedBox(height: 40),

                  // Champ Email
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Champ Mot de passe
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(),
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

                  // Bouton de connexion
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(fontSize: isLargeScreen ? 20 : 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Lien pour s'inscrire
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  // Lien pour réinitialiser le mot de passe
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reset-password');
                    },
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
