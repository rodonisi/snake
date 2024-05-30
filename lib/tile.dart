import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:snake/constants.dart';
import 'package:snake/game.dart';
import 'package:snake/snake.dart';

class Food extends RectangleComponent
    with CollisionCallbacks, HasGameReference<SnakeGame> {
  Food()
      : super(
          paint: Paint()..color = const Color(0xffff00ff),
          size: Vector2.all(Constants.tileSize - Constants.gutter),
          children: [RectangleHitbox()],
        );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SnakeTile) {
      add(
        RemoveEffect(
          onComplete: () => game.eat(),
        ),
      );
    }
    super.onCollision(intersectionPoints, other);
  }
}
