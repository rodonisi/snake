import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake/model/game_state_model.dart';
import 'package:snake/widget/food_tile.dart';
import 'package:snake/widget/snake_tile.dart';

class GameBoard extends StatefulWidget {
  final GameStateModel model;
  const GameBoard({Key? key, required this.model}) : super(key: key);

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
    widget.model.move();
    setState(() {
      if (widget.model.speed < _currentSpeed) {
        _refreshTimer();
      }
    });
  }

  void _refreshTimer() {
    _timer.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: widget.model.speed),
      _timerCallback,
    );
    _currentSpeed = widget.model.speed;
  }

  @override
  Widget build(BuildContext context) {
    _grid = List.generate(
      widget.model.gridSize * widget.model.gridSize,
      (index) => const Card(),
    );
    for (var p in widget.model.snake) {
      final i = (p.y * widget.model.gridSize + p.x);
      _grid[i] = const SnakeTile();
    }

    final gridIndex =
        widget.model.food.y * widget.model.gridSize + widget.model.food.x;
    _grid[gridIndex] = const FoodTile();

    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: widget.model.gridSize,
      children: _grid,
    );
  }
}
