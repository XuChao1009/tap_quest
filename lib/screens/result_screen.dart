import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'level_selection_screen.dart';

class ResultScreen extends StatelessWidget {
  final int level;
  final int score;

  const ResultScreen({
    super.key,
    required this.level,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const maxWidth = 600.0;
        final isWide = constraints.maxWidth >= 600;

        final title = Text(
          'Level $level finished!',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        );

        final scoreText = Text(
          'Your score: $score',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        );

        final backButton = ElevatedButton(
          onPressed: () => Get.offAll(() => const LevelSelectionScreen()),
          child: const Text('Back to Levels'),
        );

        Widget content;
        if (isWide) {
          content = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    const SizedBox(height: 16),
                    scoreText,
                  ],
                ),
              ),
              const SizedBox(width: 24),
              backButton,
            ],
          );
        } else {
          content = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title,
              const SizedBox(height: 16),
              scoreText,
              const SizedBox(height: 24),
              backButton,
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Result')),
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
