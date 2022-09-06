import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake/controller/game_view_model.dart';
import 'package:snake/widget/board_tile.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<GameNotifier>();
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: notifier.gridSize,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notifier.gridSize * notifier.gridSize,
      itemBuilder: (BuildContext context, int index) {
        final y = index ~/ notifier.gridSize;
        final x = index - y * notifier.gridSize;
        final point = Point(x, y);
        return BoardTile(
          point: point,
          snake: notifier.snake,
          food: notifier.food,
        );
      },
    );
  }
}
