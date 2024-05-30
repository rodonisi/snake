import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:snake/game.dart';

void main() {
  runApp(
    GameWidget(
      game: SnakeGame(),
    ),
  );
}
