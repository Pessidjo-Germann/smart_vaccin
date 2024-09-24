import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class VaccineCalendarScreen extends StatefulWidget {
  @override
  _VaccineCalendarScreenState createState() => _VaccineCalendarScreenState();
}

class _VaccineCalendarScreenState extends State<VaccineCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Exemple de données de vaccinations à venir
  final Map<DateTime, List<String>> _vaccinationEvents = {
    DateTime(2024, 9, 15): ['BCG'],
    DateTime(2024, 10, 1): ['Polio'],
    DateTime(2024, 11, 5): ['Hépatite B'],
  };

  // Fonction pour récupérer les événements (vaccins) d'un jour donné
  List<String> _getEventsForDay(DateTime day) {
    return _vaccinationEvents[day] ?? [];
  }

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
            Text('Calendrier des vaccinations'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: _getEventsForDay,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _selectedDay == null
                  ? Center(
                child: Text('Sélectionnez un jour pour voir les vaccinations.'),
              )
                  : ListView(
                children: _getEventsForDay(_selectedDay!).map((event) {
                  return ListTile(
                    title: Text(
                      event,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    leading: Icon(Icons.check_circle, color: Colors.green),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
