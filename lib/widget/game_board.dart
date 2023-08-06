import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/bloc/game_bloc.dart';
import 'package:snake/widget/board_tile.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: SnakeState.gridSize,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: SnakeState.gridSize * SnakeState.gridSize,
      itemBuilder: (BuildContext context, int index) {
        final y = index ~/ SnakeState.gridSize;
        final x = index - y * SnakeState.gridSize;
        final point = Point(x, y);
        return BoardTile(
          point: point,
        );
      },
    );
  }
}
