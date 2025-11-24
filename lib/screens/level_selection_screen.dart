import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_screen.dart';
import '../controllers/progress_controller.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  String _labelForLevel(ProgressController c, int level) {
    if (c.isCompleted(level)) {
      return 'Level $level (Completed)';
    }
    return 'Level $level';
  }

  @override
  Widget build(BuildContext context) {
    final progressController = Get.find<ProgressController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        const maxWidth = 600.0;
        final isWide = constraints.maxWidth >= 600;

        return Obx(() {
          final b1 = ElevatedButton(
            onPressed: () => Get.to(() => const GameScreen(level: 1)),
            child: Text(_labelForLevel(progressController, 1)),
          );

          final b2 = ElevatedButton(
            onPressed: () => Get.to(() => const GameScreen(level: 2)),
            child: Text(_labelForLevel(progressController, 2)),
          );

          final b3 = ElevatedButton(
            onPressed: () => Get.to(() => const GameScreen(level: 3)),
            child: Text(_labelForLevel(progressController, 3)),
          );

          Widget buttonsLayout;
          if (isWide) {
            buttonsLayout = Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [b1, b2, b3],
            );
          } else {
            buttonsLayout = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                b1,
                const SizedBox(height: 16),
                b2,
                const SizedBox(height: 16),
                b3,
              ],
            );
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Choose Level")),
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: buttonsLayout,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
