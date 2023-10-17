import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const _keySearchHistory = 'searchHistory';

  static Future<List<String>> getSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> searchHistory = prefs.getStringList(_keySearchHistory) ?? [];
    return searchHistory;
  }

  static Future<void> addToSearchHistory(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> searchHistory = prefs.getStringList(_keySearchHistory) ?? [];
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
      await prefs.setStringList(_keySearchHistory, searchHistory);
    }
  }

  static Future<void> clearSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySearchHistory);
  }
}
