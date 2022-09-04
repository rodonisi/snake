import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/controller/game_state_controller.dart';
import 'package:snake/widget/food_tile.dart';
import 'package:snake/widget/snake_tile.dart';

class GameBoard extends StatefulWidget {
  final GameStateController controller;
  const GameBoard({Key? key, required this.controller}) : super(key: key);

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
    widget.controller.move();
    setState(() {
      if (widget.controller.speed != _currentSpeed) {
        _refreshTimer();
      }
    });
  }

  void _refreshTimer() {
    _timer.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: widget.controller.speed),
      _timerCallback,
    );
    _currentSpeed = widget.controller.speed;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.controller.gridSize,
      ),
      itemCount: widget.controller.gridSize * widget.controller.gridSize,
      itemBuilder: (BuildContext context, int index) {
        final y = index ~/ widget.controller.gridSize;
        final x = index - y * widget.controller.gridSize;
        final point = Point(x, y);
        if (widget.controller.snake.contains(point)) {
          return const SnakeTile();
        }
        if (widget.controller.food == point) {
          return const FoodTile();
        }

        return const Card();
      },
    );
  }
}
