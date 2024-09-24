import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartvaccin/Screen/Auth/login_screen.dart';
import 'package:smartvaccin/Screen/Auth/register_screen.dart';
import 'package:smartvaccin/Screen/parent/parent_dashbord_screen.dart';
import 'package:smartvaccin/Screen/Administrateur/admin_dasbord_screen.dart';
import 'package:smartvaccin/Screen/Personel medicale/medical_dashboard_screen.dart';
import 'package:smartvaccin/Screen/Auth/reset_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Vaccin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Page initiale
      routes: {
        '/login': (context) => LoginScreen(), // Page de connexion
        '/register': (context) => RegisterScreen(), // Page d'inscription
        '/reset-password': (context) =>
            ResetPasswordScreen(), // Page de réinitialisation du mot de passe
        '/parent-home': (context) =>
            ParentHomeScreen(), // Tableau de bord des parents
        '/medical-dashboard': (context) =>
            MedicalDashboardScreen(), // Tableau de bord du personnel médical
        '/admin-dashboard': (context) =>
            AdminDashboardScreen(), // Tableau de bord des administrateurs
      },
    );
  }
}
