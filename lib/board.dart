import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake/constants.dart';
import 'package:snake/game.dart';

class Board extends RectangleComponent
    with HasGameReference<SnakeGame>, CollisionCallbacks {
  Board()
      : super(
          paint: Paint()..color = const Color(0xff333333),
          children: [RectangleHitbox(collisionType: CollisionType.passive)],
        );

  @override
  Future<void> onLoad() async {
    size = Constants.worldSize;
  }
}
