import 'package:flutter/material.dart';
import '../services/progress_manager.dart';
import 'game_screen.dart';

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  List<int> completed = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    completed = await ProgressManager().loadCompletedLevels();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final levels = [1, 2, 3];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Level")),
      body: ListView(
        children: levels.map((level) {
          final done = completed.contains(level);
          return ListTile(
            title: Text("Level $level"),
            trailing: done
                ? const Text("✔ Completed", style: TextStyle(color: Colors.green))
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GameScreen(level: level),
                ),
              ).then((_) => _load());
            },
          );
        }).toList(),
      ),
    );
  }
}
