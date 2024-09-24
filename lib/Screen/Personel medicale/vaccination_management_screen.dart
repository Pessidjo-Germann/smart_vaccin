import 'package:flutter/material.dart';

class VaccinationManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Vaccinations'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Bouton Enregistrer une vaccination
            _buildFeatureButton(
              context,
              'Enregistrer une vaccination',
              Icons.add,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnregistrerVaccinationScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // Bouton Consulter le dossier médical
            _buildFeatureButton(
              context,
              'Consulter le dossier médical',
              Icons.folder_open,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsulterDossierMedicalScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // Bouton Générer un certificat de vaccination
            _buildFeatureButton(
              context,
              'Générer un certificat de vaccination',
              Icons.picture_as_pdf,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenererCertificatScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour construire les boutons de fonctionnalités
  Widget _buildFeatureButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(label, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

// Écran Enregistrer une vaccination
class EnregistrerVaccinationScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _vaccineController = TextEditingController();
  final TextEditingController _dateVaccinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enregistrer une vaccination'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom de l\'enfant'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _prenomController,
              decoration: InputDecoration(labelText: 'Prénom de l\'enfant'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _vaccineController,
              decoration: InputDecoration(labelText: 'Nom du vaccin'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _dateVaccinationController,
              decoration: InputDecoration(labelText: 'Date de vaccination'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  _dateVaccinationController.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
              readOnly: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Logique pour enregistrer la vaccination
              },
              child: Text('Enregistrer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Écran Consulter le dossier médical
class ConsulterDossierMedicalScreen extends StatelessWidget {
  final String nomEnfant = 'Dupont';
  final String prenomEnfant = 'Jean';
  final String dateNaissance = '15/05/2015';
  final List<String> vaccinsPris = [
    'BCG - 20/06/2020',
    'Polio - 15/09/2021',
    'Hépatite B - 30/11/2022',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossier Médical de l\'enfant'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: $nomEnfant', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Prénom: $prenomEnfant', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Date de naissance: $dateNaissance', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Vaccins pris:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...vaccinsPris.map((vaccin) => Text(vaccin, style: TextStyle(fontSize: 16))).toList(),
          ],
        ),
      ),
    );
  }
}

// Écran Générer un certificat de vaccination
class GenererCertificatScreen extends StatelessWidget {
  final String nomEnfant = 'Evrad';
  final String prenomEnfant = 'Liam';
  final String dateNaissance = '18/05/2022';
  final String nomVaccin = 'Polio';
  final String validiteVaccination = '01/01/2026';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificat de Vaccination'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: $nomEnfant', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Prénom: $prenomEnfant', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Date de naissance: $dateNaissance', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Vaccin: $nomVaccin', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Validité jusqu\'au: $validiteVaccination', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
