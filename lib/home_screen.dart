import 'package:flutter/material.dart';
import 'mood_provider.dart';
import 'mood_entry.dart';
import 'add_mood_screen.dart';
import 'stats_screen.dart';
import 'insights_screen.dart'; // Import the Insights screen
import 'package:provider/provider.dart';
import 'colors.dart';
import 'text_styles.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker', style: AppTextStyles.headline1),
        backgroundColor: AppColors.accent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'How was your day?',
              style: AppTextStyles.headline1,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: moodProvider.entries.length,
              itemBuilder: (ctx, i) {
                final entry = moodProvider.entries[i];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: AppColors.accent.withOpacity(0.1),
                  child: ListTile(
                    leading: Text(entry.mood, style: TextStyle(fontSize: 30)),
                    title: Text(entry.date.toLocal().toString(),
                        style: AppTextStyles.bodyText1),
                    subtitle: entry.note != null
                        ? Text(entry.note!, style: AppTextStyles.caption)
                        : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMoodScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Add Mood'),
                ),
                SizedBox(height: 16), // Add space between buttons
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InsightsScreen()), // Navigate to Insights screen
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('View Insights'), // Button text
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.show_chart),
        backgroundColor: AppColors.accent,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StatsScreen()),
        ),
      ),
    );
  }
}
