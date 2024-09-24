import 'package:flutter/material.dart';

class ReminderSettingsScreen extends StatefulWidget {
  @override
  _ReminderSettingsScreenState createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  // Variables pour stocker les préférences du parent
  bool _isPushNotificationEnabled = false;
  bool _isSmsNotificationEnabled = false;
  int _reminderFrequency = 1; // Fréquence des rappels en jours (1 jour par défaut)

  // Numéro de téléphone du parent pour l'envoi de SMS
  final TextEditingController _phoneNumberController = TextEditingController();

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
            Text('Configuration des rappels'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section pour activer les notifications push
            SwitchListTile(
              title: Text(
                'Activer les notifications push',
                style: TextStyle(fontSize: 18),
              ),
              value: _isPushNotificationEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isPushNotificationEnabled = value;
                });
              },
              activeColor: Colors.blue.shade700,
            ),
            SizedBox(height: 20),

            // Section pour activer les rappels par SMS
            SwitchListTile(
              title: Text(
                'Activer les rappels par SMS',
                style: TextStyle(fontSize: 18),
              ),
              value: _isSmsNotificationEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isSmsNotificationEnabled = value;
                });
              },
              activeColor: Colors.blue.shade700,
            ),
            // Champ pour entrer le numéro de téléphone
            if (_isSmsNotificationEnabled)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            SizedBox(height: 20),

            // Section pour choisir la fréquence des rappels
            Text(
              'Fréquence des rappels (en jours avant la date de vaccination) :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _reminderFrequency.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              label: '$_reminderFrequency jour(s)',
              onChanged: (double value) {
                setState(() {
                  _reminderFrequency = value.toInt();
                });
              },
              activeColor: Colors.blue.shade700,
            ),
            SizedBox(height: 40),

            // Bouton de sauvegarde des paramètres
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action pour sauvegarder les paramètres
                  String message = 'Rappels configurés avec succès :\n';
                  message += _isPushNotificationEnabled
                      ? ' - Notifications push activées\n'
                      : ' - Notifications push désactivées\n';
                  message += _isSmsNotificationEnabled
                      ? ' - Rappels par SMS activés au numéro : ${_phoneNumberController.text}\n'
                      : ' - Rappels par SMS désactivés\n';
                  message += ' - Fréquence des rappels : $_reminderFrequency jour(s) avant la vaccination';

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
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
            ),
          ],
        ),
      ),
    );
  }
}
