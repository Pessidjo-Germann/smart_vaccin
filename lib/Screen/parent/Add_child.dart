import 'package:flutter/material.dart';

class AddChildScreen extends StatefulWidget {
  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variables pour stocker les informations saisies
  String? _name;
  String? _surname;
  DateTime? _birthDate;
  bool _isMale = true; // Le sexe est un booléen, true pour Masculin, false pour Féminin
  String? _address;
  String? _phone;

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
            Text('Ajouter un enfant'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Champ pour le nom de l'enfant
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'enfant';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16),

              // Champ pour le prénom de l'enfant
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le prénom de l\'enfant';
                  }
                  return null;
                },
                onSaved: (value) {
                  _surname = value;
                },
              ),
              SizedBox(height: 16),

              // Champ pour la date de naissance
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode()); // Empêcher le clavier d'apparaître
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _birthDate = pickedDate;
                    });
                  }
                },
                readOnly: true,
                validator: (value) {
                  if (_birthDate == null) {
                    return 'Veuillez sélectionner la date de naissance';
                  }
                  return null;
                },
                controller: TextEditingController(
                    text: _birthDate == null
                        ? ''
                        : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'),
              ),
              SizedBox(height: 16),

              // Champ pour le sexe avec un switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sexe : ${_isMale ? 'Masculin' : 'Féminin'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: _isMale,
                    onChanged: (bool value) {
                      setState(() {
                        _isMale = value;
                      });
                    },
                    activeColor: Colors.blue.shade700,
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Champ pour l'adresse
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value;
                },
              ),
              SizedBox(height: 16),

              // Champ pour le téléphone
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le numéro de téléphone';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value;
                },
              ),
              SizedBox(height: 40),

              // Bouton d'enregistrement
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Action d'enregistrement à implémenter
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Enfant ajouté avec succès')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Enregistrer',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
