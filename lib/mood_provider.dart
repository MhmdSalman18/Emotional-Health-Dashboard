import 'package:flutter/material.dart';
import 'mood_entry.dart';

class MoodProvider with ChangeNotifier {
  List<MoodEntry> _entries = [];

  List<MoodEntry> get entries => _entries;

  void addEntry(MoodEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }
}
