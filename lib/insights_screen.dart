import 'package:flutter/material.dart';
import 'mood_provider.dart';
import 'insights_helper.dart';
import 'package:provider/provider.dart';

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context);
    final moodEntries = moodProvider.entries;
    final insights = analyzeMoodPatterns(moodEntries);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Insights'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: insights.isNotEmpty
            ? Text(
                insights,
                style: TextStyle(fontSize: 18.0),
              )
            : Center(
                child: Text(
                  'Not enough data for insights. Log more moods to see trends!',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}
