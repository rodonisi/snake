import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:snake/board.dart';
import 'package:snake/constants.dart';
import 'package:snake/game.dart';

enum Direction {
  up(direction: (0, -1)),
  down(direction: (0, 1)),
  left(direction: (-1, 0)),
  right(direction: (1, 0)),
  none(direction: (0, 0));

  const Direction({required this.direction});

  final (double, double) direction;

  Vector2 get vector => Vector2(
      direction.$1 * Constants.tileSize, direction.$2 * Constants.tileSize);

  bool isOpposite(Direction other) =>
      direction.$1 == -other.direction.$1 &&
      direction.$2 == -other.direction.$2;
}

class Snake extends Component
    with HasGameReference<SnakeGame>, KeyboardHandler {
  Direction direction = Direction.none;
  List<SnakeTile> tiles = [];
  int length = 5;

  Snake();

  void move() {
    if (direction == Direction.none) {
      return;
    }

    tiles.add(SnakeTile()..position = tiles.last.position + direction.vector);
    add(tiles.last);
    if (tiles.length > length) {
      final r = tiles.removeAt(0);
      remove(r);
    }
  }

  @override
  FutureOr<void> onLoad() {
    add(TimerComponent(period: 0.2, onTick: move, repeat: true));
    tiles.add(SnakeTile()..position = game.size / 2);
    addAll(tiles);
    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final keys = {
      LogicalKeyboardKey.arrowDown: Direction.down,
      LogicalKeyboardKey.arrowUp: Direction.up,
      LogicalKeyboardKey.arrowLeft: Direction.left,
      LogicalKeyboardKey.arrowRight: Direction.right,
    }..removeWhere((key, value) =>
        !keysPressed.contains(key) || value.isOpposite(direction));

    if (keys.isNotEmpty) {
      direction = keys.values.first;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}

class SnakeTile extends RectangleComponent
    with CollisionCallbacks, HasGameReference<SnakeGame> {
  SnakeTile()
      : super(
          size: Vector2.all(Constants.tileSize - Constants.gutter),
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xff0000ff),
          children: [RectangleHitbox()],
        );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SnakeTile || other is Board) {
      parent?.add(
          RemoveEffect(onComplete: () => game.playState = PlayState.gameOver));
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    print('Collision start with $other');
    super.onCollisionStart(intersectionPoints, other);
  }
}
