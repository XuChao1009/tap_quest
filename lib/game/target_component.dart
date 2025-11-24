import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'level_config.dart';
import 'tap_quest_game.dart';

class TargetComponent extends PositionComponent
    with TapCallbacks, HasGameRef<TapQuestGame> {
  final LevelConfig config;
  late Vector2 velocity;
  final Random _random = Random();

  TargetComponent({required this.config}) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2.all(80);
    position = gameRef.size / 2;
    velocity = _initialVelocity();
  }

  Vector2 _initialVelocity() {
    switch (config.movementType) {
      case MovementType.horizontal:
        return Vector2(config.speed, 0);
      case MovementType.vertical:
        return Vector2(0, config.speed);
      case MovementType.diagonal:
        return Vector2(config.speed, config.speed);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    final w = gameRef.size.x;
    final h = gameRef.size.y;
    final halfW = size.x / 2;
    final halfH = size.y / 2;

    if (position.x < halfW || position.x > w - halfW) {
      if (config.movementType != MovementType.vertical) {
        velocity.x = -velocity.x;
      }
      position.x = position.x.clamp(halfW, w - halfW);
    }

    if (position.y < halfH || position.y > h - halfH) {
      if (config.movementType != MovementType.horizontal) {
        velocity.y = -velocity.y;
      }
      position.y = position.y.clamp(halfH, h - halfH);
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = _colorForLevel();
    final rect = Rect.fromCenter(
      center: Offset(size.x / 2, size.y / 2),
      width: size.x,
      height: size.y,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      paint,
    );
  }

  Color _colorForLevel() {
    if (config.level == 1) return const Color(0xFF4CAF50);
    if (config.level == 2) return const Color(0xFF2196F3);
    return const Color(0xFFFFC107);
  }

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.registerHit();
    _teleportRandomly();
  }

  void _teleportRandomly() {
    final w = gameRef.size.x;
    final h = gameRef.size.y;
    final halfW = size.x / 2;
    final halfH = size.y / 2;

    final x = _random.nextDouble() * (w - 2 * halfW) + halfW;
    final y = _random.nextDouble() * (h - 2 * halfH) + halfH;

    position.setValues(x, y);
  }
}
