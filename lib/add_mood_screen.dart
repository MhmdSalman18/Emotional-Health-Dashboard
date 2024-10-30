import 'package:flutter/material.dart';
import 'mood_provider.dart';
import 'mood_entry.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'text_styles.dart';

class AddMoodScreen extends StatefulWidget {
  @override
  _AddMoodScreenState createState() => _AddMoodScreenState();
}

class _AddMoodScreenState extends State<AddMoodScreen> {
  String _selectedMood = '😊';
  final _noteController = TextEditingController();

  void _saveMood() {
    final newEntry = MoodEntry(
      date: DateTime.now(),
      mood: _selectedMood,
      note: _noteController.text,
    );

    Provider.of<MoodProvider>(context, listen: false).addEntry(newEntry);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log Your Mood', style: AppTextStyles.headline1), backgroundColor: AppColors.accent,),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('How are you feeling today?', style: AppTextStyles.headline1),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedMood,
              icon: Icon(Icons.emoji_emotions, color: AppColors.accent),
              items: ['😊', '😐', '😢', '😠'].map((mood) {
                return DropdownMenuItem(value: mood, child: Text(mood, style: TextStyle(fontSize: 24)));
              }).toList(),
              onChanged: (value) => setState(() => _selectedMood = value!),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Add a note (optional)',
                labelStyle: AppTextStyles.bodyText1,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveMood,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text('Save Mood', style: AppTextStyles.bodyText1.copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
