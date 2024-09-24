import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isMale = true;  // Booléen pour le sexe (masculin par défaut)
  String _selectedRole = 'parent';  // Valeur par défaut du rôle
  bool _obscureText = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fonction pour gérer l'inscription de l'utilisateur
  void _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String userId = userCredential.user!.uid;

      // Déterminer dans quelle collection ajouter les informations en fonction du rôle
      String collection = '';
      if (_selectedRole == 'parent') {
        collection = 'parents';
      } else if (_selectedRole == 'medical') {
        collection = 'personnel_medical';
      } else if (_selectedRole == 'admin') {
        collection = 'administrateurs';
      }

      // Ajouter les informations de l'utilisateur dans la bonne collection
      await FirebaseFirestore.instance.collection(collection).doc(userId).set({
        'nom': _nomController.text,
        'prenom': _prenomController.text,
        'email': _emailController.text,
        'telephone': _phoneController.text,
        'sexe': _isMale ? 'masculin' : 'feminin',
        'role': _selectedRole,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Inscription réussie'),
      ));

      Navigator.pushReplacementNamed(context, '/login'); // Redirection vers la page de connexion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur d\'inscription : ${e.toString()}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo g.jpg', // Chemin du logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Créer un compte - Smart Vaccin'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Champ Nom
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Champ Prénom
                TextField(
                  controller: _prenomController,
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Champ Téléphone
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Téléphone',
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Champ Sexe (booléen)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sexe :'),
                    SizedBox(width: 20),
                    Text('Masculin'),
                    Switch(
                      value: !_isMale,
                      onChanged: (value) {
                        setState(() {
                          _isMale = !value;
                        });
                      },
                    ),
                    Text('Féminin'),
                  ],
                ),
                SizedBox(height: 16),

                // Champ Rôle
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  items: [
                    DropdownMenuItem(value: 'parent', child: Text('Parent')),
                    DropdownMenuItem(value: 'medical', child: Text('Personnel Médical')),
                    DropdownMenuItem(value: 'admin', child: Text('Administrateur')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Rôle',
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

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

                // Bouton S'inscrire
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'S\'inscrire',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
