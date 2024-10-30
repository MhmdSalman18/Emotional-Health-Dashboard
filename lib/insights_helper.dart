// insights_helper.dart
import 'package:mood_tracker/mood_entry.dart';

String analyzeMoodPatterns(List<MoodEntry> entries) {
  final weekdayMoods = List.generate(7, (index) => <String>[]);

  // Group mood entries by weekday
  for (var entry in entries) {
    weekdayMoods[entry.date.weekday - 1].add(entry.mood);
  }

  final insights = StringBuffer();
  for (int i = 0; i < weekdayMoods.length; i++) {
    final day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][i];
    if (weekdayMoods[i].isNotEmpty) {
      final mostCommonMood = findMostCommonMood(weekdayMoods[i]);
      insights.writeln('$day tends to be a "$mostCommonMood" day.');
    }
  }
  return insights.toString();
}

String findMostCommonMood(List<String> moods) {
  final moodCounts = <String, int>{};

  for (var mood in moods) {
    moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
  }

  // Find the most common mood
  return moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
}
