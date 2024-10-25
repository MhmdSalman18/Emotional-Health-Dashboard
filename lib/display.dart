import 'package:flutter/material.dart';

class EntryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here, you would typically fetch your entries from a backend API.
    // For demonstration, we'll create some mock entries.
    final List<Map<String, String>> entries = [
      {
        'date': '2024-10-01T12:00:00',
        'description': 'Sample Entry 1',
      },
      {
        'date': '2024-10-02T14:30:00',
        'description': 'Sample Entry 2',
      },
      {
        'date': '2024-10-03T16:45:00',
        'description': 'Sample Entry 3',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Media Entries')),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          DateTime entryDate = DateTime.parse(entry['date']!);
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(entry['description']!),
              subtitle: Text(
                'Date: ${entryDate.toLocal().toString().split(' ')[0]}, '
                'Time: ${entryDate.hour}:${entryDate.minute.toString().padLeft(2, '0')}',
              ),
            ),
          );
        },
      ),
    );
  }
}
