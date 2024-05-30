import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake/constants.dart';
import 'package:snake/game.dart';

class Board extends RectangleComponent
    with HasGameReference<SnakeGame>, CollisionCallbacks {
  Board()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
          children: [RectangleHitbox()],
        );

  @override
  Future<void> onLoad() async {
    size = Constants.worldSize;
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('Collision with $other');
    super.onCollision(intersectionPoints, other);
  }
}
