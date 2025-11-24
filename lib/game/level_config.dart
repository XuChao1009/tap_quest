enum MovementType {
  horizontal,
  vertical,
  diagonal,
}

class LevelConfig {
  final int level;
  final MovementType movementType;
  final double speed;

  const LevelConfig({
    required this.level,
    required this.movementType,
    required this.speed,
  });
}

const levelConfigs = [
  LevelConfig(
    level: 1,
    movementType: MovementType.horizontal,
    speed: 150,
  ),
  LevelConfig(
    level: 2,
    movementType: MovementType.vertical,
    speed: 200,
  ),
  LevelConfig(
    level: 3,
    movementType: MovementType.diagonal,
    speed: 220,
  ),
];
