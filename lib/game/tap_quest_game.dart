import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum MovementMode {
  horizontal,
  diagonal,
  randomJump,
}

class TapQuestGame extends FlameGame {
  final int level;
  final void Function(int score) onGameFinished;

  late TargetComponent target;
  late TextComponent hud;

  int score = 0;
  double timeLeft = 30;
  bool finished = false;

  TapQuestGame({
    required this.level,
    required this.onGameFinished,
  });

  MovementMode get movementMode {
    switch (level) {
      case 1:
        return MovementMode.horizontal;
      case 2:
        return MovementMode.diagonal;
      case 3:
        return MovementMode.randomJump;
      default:
        return MovementMode.horizontal;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // HUD 放在左上角，避免依赖 camera viewport API
    hud = TextComponent(
      text: 'Time: 30.0  Score: 0',
      anchor: Anchor.topLeft,
      position: Vector2(16, 16),
      priority: 10,
    );
    add(hud);

    target = TargetComponent(
      movementMode: movementMode,
      onTap: _handleTap,
    )
      ..radius = 25
      ..paint = (Paint()..color = Colors.orange)
      ..anchor = Anchor.center;

    add(target);
  }

  void _handleTap() {
    if (finished) return;
    score++;
    hud.text = 'Time: ${timeLeft.toStringAsFixed(1)}  Score: $score';
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (finished) return;

    timeLeft -= dt;

    if (timeLeft <= 0) {
      finished = true;
      timeLeft = 0;
      hud.text = 'Time: 0.0  Score: $score';
      onGameFinished(score);
    } else {
      hud.text = 'Time: ${timeLeft.toStringAsFixed(1)}  Score: $score';
    }
  }
}

class TargetComponent extends CircleComponent
    with TapCallbacks, HasGameRef<TapQuestGame> {
  MovementMode movementMode;
  void Function() onTap;
  Vector2 velocity = Vector2.zero();
  double jumpTimer = 0;
  final Random _random = Random();

  TargetComponent({
    required this.movementMode,
    required this.onTap,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 初始放在屏幕中心
    position = gameRef.size / 2;

    switch (movementMode) {
      case MovementMode.horizontal:
        velocity = Vector2(100, 0);
        break;
      case MovementMode.diagonal:
        velocity = Vector2(120, 80);
        break;
      case MovementMode.randomJump:
        velocity = Vector2.zero();
        break;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final bounds = gameRef.size;

    switch (movementMode) {
      case MovementMode.horizontal:
      case MovementMode.diagonal:
        position += velocity * dt;

        if (position.x - radius < 0 || position.x + radius > bounds.x) {
          velocity.x = -velocity.x;
        }

        if (movementMode == MovementMode.diagonal) {
          if (position.y - radius < 0 || position.y + radius > bounds.y) {
            velocity.y = -velocity.y;
          }
        }
        break;

      case MovementMode.randomJump:
        jumpTimer += dt;
        if (jumpTimer >= 1) {
          jumpTimer = 0;
          final margin = radius + 10;
          final x = margin + _random.nextDouble() * (bounds.x - 2 * margin);
          final y = margin + _random.nextDouble() * (bounds.y - 2 * margin);
          position.setValues(x, y);
        }
        break;
    }
  }
}
