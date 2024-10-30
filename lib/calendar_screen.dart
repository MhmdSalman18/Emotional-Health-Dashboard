import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'mood_provider.dart';
import 'package:provider/provider.dart';
import 'colors.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context);
    final entriesByDate = moodProvider.entries.where((entry) => entry.date.day == _selectedDay.day).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Calendar', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.now(),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entriesByDate.length,
              itemBuilder: (context, index) {
                final entry = entriesByDate[index];
                return ListTile(
                  title: Text(
                    entry.mood,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(entry.note ?? 'No notes for this day'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
