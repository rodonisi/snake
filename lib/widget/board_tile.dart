import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/bloc/game_bloc.dart';
import 'package:snake/widget/snake_tile.dart';

import 'food_tile.dart';

class BoardTile extends StatelessWidget {
  final Point<int> point;
  const BoardTile({
    super.key,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SnakeBloc, SnakeState>(
      buildWhen: (previous, current) =>
          previous.snake.contains(point) != current.snake.contains(point) ||
          (previous.food == point) != (current.food == point),
      builder: (context, state) {
        if (state.snake.contains(point)) {
          return const SnakeTile();
        }
        if (state.food == point) {
          return const FoodTile();
        }

        return Container();
      },
    );
  }
}
