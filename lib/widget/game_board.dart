import 'dart:async';

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
  List<Widget> _grid = [];
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
    _grid = List.generate(
      widget.controller.gridSize * widget.controller.gridSize,
      (index) => const Card(),
    );
    for (var p in widget.controller.snake) {
      final i = (p.y * widget.controller.gridSize + p.x);
      _grid[i] = const SnakeTile();
    }

    final gridIndex = widget.controller.food.y * widget.controller.gridSize +
        widget.controller.food.x;
    _grid[gridIndex] = const FoodTile();

    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: widget.controller.gridSize,
      children: _grid,
    );
  }
}
