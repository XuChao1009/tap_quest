import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressController extends GetxController {
  final completedLevels = <int>{}.obs;
  static const _storageKey = 'completed_levels';

  @override
  void onInit() {
    super.onInit();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_storageKey) ?? [];
    completedLevels.value = list.map(int.parse).toSet();
  }

  Future<void> markCompleted(int level) async {
    completedLevels.add(level);
    completedLevels.refresh();
    final prefs = await SharedPreferences.getInstance();
    final list = completedLevels.map((e) => e.toString()).toList();
    await prefs.setStringList(_storageKey, list);
  }

  bool isCompleted(int level) {
    return completedLevels.contains(level);
  }
}
