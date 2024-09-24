import 'package:flutter/material.dart';

class VaccinationScreen extends StatelessWidget {
  // Exemples de données sur les vaccinations
  final List<Map<String, dynamic>> vaccinations = [
    {
      'vaccineName': 'BCG',
      'date': '15/09/2024',
      'status': 'À venir',
    },
    {
      'vaccineName': 'Polio',
      'date': '01/10/2024',
      'status': 'Complété',
    },
    {
      'vaccineName': 'Hépatite B',
      'date': '05/11/2024',
      'status': 'À venir',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // Chemin vers le logo de l'application
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Suivi des vaccinations'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: vaccinations.length,
          itemBuilder: (context, index) {
            final vaccination = vaccinations[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vaccination['vaccineName'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Date : ${vaccination['date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      vaccination['status'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: vaccination['status'] == 'Complété'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
