import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'level_selection_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const maxWidth = 600.0;
        final isWide = constraints.maxWidth >= 600;

        final title = Text(
          'Tap Quest',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        );

        final startButton = ElevatedButton(
          onPressed: () => Get.to(() => LevelSelectionScreen()),
          child: const Text('Start'),
        );

        Widget content;
        if (isWide) {
          content = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: title),
              const SizedBox(width: 24),
              startButton,
            ],
          );
        } else {
          content = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title,
              const SizedBox(height: 24),
              startButton,
            ],
          );
        }

        return Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}
