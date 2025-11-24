import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {
  static const _key = "completed_levels";

  Future<List<int>> loadCompletedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.map(int.parse).toList() ?? [];
  }

  Future<void> markLevelCompleted(int level) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await loadCompletedLevels();
    if (!list.contains(level)) {
      list.add(level);
      await prefs.setStringList(
        _key,
        list.map((e) => e.toString()).toList(),
      );
    }
  }
}
