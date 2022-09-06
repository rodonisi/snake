import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/helpers/global_logger.dart';
import 'package:snake/model/game_model.dart';
import 'package:snake/utility/fixed_queue.dart';

class GameNotifier extends ChangeNotifier {
  GameModel _model = GameModel();

  int get gridSize => _model.gridSize;
  Point<int> get food => _model.food;
  FixedQueue<Point<int>> get snake => _model.snake;

  set direction(Direction direction) {
    _model.currentDirection = direction;
  }

  void start() {
    startTimer();
  }

  void refresh() {
    if (_model.state == GameState.running) {
      _model.move();
    } else if (_model.state == GameState.collision) {
      logger.d("restart game");
      _model = GameModel();
    }
    notifyListeners();
  }

  void startTimer() {
    Timer.periodic(Duration(milliseconds: _model.speed), (_) => refresh());
  }
}
