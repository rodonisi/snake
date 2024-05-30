import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake/constants.dart';
import 'package:snake/game.dart';

class Board extends RectangleComponent with HasGameReference<SnakeGame> {
  Board()
      : super(
          paint: Paint()..color = const Color(0xff333333),
          size: Constants.worldSize,
          children: [RectangleHitbox()],
        );
}
