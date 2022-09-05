import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/controller/game_view_model.dart';
import 'package:snake/widget/food_tile.dart';
import 'package:snake/widget/snake_tile.dart';

class GameBoard extends StatefulWidget {
  final GameViewModel viewModel;
  const GameBoard({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late Timer _timer;
  int _currentSpeed = 1000;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
    super.initState();
  }

  void _timerCallback(Timer timer) {
    widget.viewModel.refresh();
    setState(() {
      if (widget.viewModel.speed != _currentSpeed) {
        _refreshTimer();
      }
    });
  }

  void _refreshTimer() {
    _timer.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: widget.viewModel.speed),
      _timerCallback,
    );
    _currentSpeed = widget.viewModel.speed;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.viewModel.gridSize,
      ),
      itemCount: widget.viewModel.gridSize * widget.viewModel.gridSize,
      itemBuilder: (BuildContext context, int index) {
        final y = index ~/ widget.viewModel.gridSize;
        final x = index - y * widget.viewModel.gridSize;
        final point = Point(x, y);
        if (widget.viewModel.snake.contains(point)) {
          return const SnakeTile();
        }
        if (widget.viewModel.food == point) {
          return const FoodTile();
        }

        return const Card();
      },
    );
  }
}
