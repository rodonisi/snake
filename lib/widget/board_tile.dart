import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/utility/fixed_queue.dart';
import 'package:snake/widget/snake_tile.dart';

import 'food_tile.dart';

class BoardTile extends StatelessWidget {
  final Point<int> point;
  final FixedQueue<Point<int>> snake;
  final Point<int> food;
  const BoardTile({
    super.key,
    required this.point,
    required this.snake,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    if (snake.contains(point)) {
      return const SnakeTile();
    }
    if (food == point) {
      return const FoodTile();
    }

    return Container();
  }
}
