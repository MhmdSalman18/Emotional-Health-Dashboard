import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'mood_provider.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'text_styles.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Trends', style: AppTextStyles.headline1),
        backgroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: true),
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: AppColors.accent,
                belowBarData: BarAreaData(show: true, color: AppColors.accent.withOpacity(0.3)),
                spots: moodProvider.entries
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value.mood == '😊' ? 3 : e.value.mood == '😐' ? 2 : 1))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
