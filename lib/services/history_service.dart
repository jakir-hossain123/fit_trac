import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _key = 'activity_history';

  // Save activity session to local storage
  static Future<void> saveSession(String type, Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> historyJson = prefs.getStringList(_key) ?? [];
    List<Map<String, dynamic>> historyList = historyJson
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();

    // Standardize keys to prevent null errors
    Map<String, dynamic> standardizedData = {
      'time': data['time'] ?? data['watchTimeSeconds'] ?? data['duration_seconds'] ?? 0,
      'steps': data['steps'] ?? 0,
      'kcal': data['kcal'] ?? 0.0,
      'distance': data['distance'] ?? 0.0,
      'name': data['name'] ?? data['videoTitle'] ?? type,
    };

    Map<String, dynamic> newEntry = {
      'type': type,
      'date': DateTime.now().toIso8601String(),
      'data': standardizedData,
    };

    historyList.insert(0, newEntry);

    // Keep only the last 7 days of history
    DateTime today = DateTime.now();
    DateTime sevenDaysAgo = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 7));

    historyList = historyList.where((item) {
      DateTime sessionDate = DateTime.parse(item['date']);
      return sessionDate.isAfter(sevenDaysAgo);
    }).toList();

    List<String> updatedJson = historyList.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(_key, updatedJson);
  }

  // Get aggregated summary for the last 7 days
  static Future<List<Map<String, dynamic>>> getLastSevenDaysSummary(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyJson = prefs.getStringList(_key) ?? [];

    List<Map<String, dynamic>> allHistory = historyJson
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();

    List<Map<String, dynamic>> lastSevenDays = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));

      // Filter sessions for specific day and activity type
      var sessionsThatDay = allHistory.where((item) {
        DateTime itemDate = DateTime.parse(item['date']);
        return itemDate.day == date.day &&
            itemDate.month == date.month &&
            itemDate.year == date.year &&
            item['type'] == type;
      }).toList();

      Map<String, dynamic> combinedData = {};
      bool hasData = sessionsThatDay.isNotEmpty;

      if (hasData) {
        // Sum up all activities performed on the same day
        double totalTime = 0;
        int totalSteps = 0;
        double totalKcal = 0;
        double totalDist = 0;

        for (var session in sessionsThatDay) {
          var d = session['data'];
          totalTime += (d['time'] ?? 0);
          totalSteps += (d['steps'] ?? 0) as int;
          totalKcal += (d['kcal'] ?? 0.0);
          totalDist += (d['distance'] ?? 0.0);
        }

        combinedData = {
          'time': totalTime,
          'steps': totalSteps,
          'kcal': totalKcal,
          'distance': totalDist,
        };
      }

      // Set human-readable labels
      String dayLabel;
      if (i == 0) dayLabel = "Today";
      else if (i == 1) dayLabel = "Yesterday";
      else dayLabel = _getDayName(date.weekday);

      lastSevenDays.add({
        'label': dayLabel,
        'date': date,
        'hasData': hasData,
        'data': hasData ? combinedData : null,
      });
    }
    return lastSevenDays;
  }

  // Helper to get day name
  static String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return "Mon";
      case 2: return "Tue";
      case 3: return "Wed";
      case 4: return "Thu";
      case 5: return "Fri";
      case 6: return "Sat";
      case 7: return "Sun";
      default: return "";
    }
  }
}