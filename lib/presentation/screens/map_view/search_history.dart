import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const _historyKey = 'search_history';

  static Future<List<String>> getSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey);
    return history ?? [];
  }

  static Future<void> addToSearchHistory(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();
    
    if (!history.contains(query)) {
      history.add(query);
      await prefs.setStringList(_historyKey, history);
    }
  }

  static Future<void> clearSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
