import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import '../game/tap_quest_game.dart';
import '../controllers/progress_controller.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  final int level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TapQuestGame game;
  final progressController = Get.find<ProgressController>();

  @override
  void initState() {
    super.initState();
    game = TapQuestGame(
      level: widget.level,
      onGameFinished: (score) async {
        await progressController.markCompleted(widget.level);
        Get.off(() => ResultScreen(level: widget.level, score: score));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${widget.level}'),
      ),
      body: GameWidget(
        game: game,
      ),
    );
  }
}
