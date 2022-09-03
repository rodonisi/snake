import 'dart:math';

import 'package:snake/model/game_state_model.dart';
import 'package:snake/utility/fixed_queue.dart';

class GameStateController {
  GameStateModel _model = GameStateModel();

  Direction get currentDirection => _model.currentDirection;
  set currentDirection(Direction direction) =>
      _model.currentDirection = direction;
  int get speed => _model.speed;
  int get gridSize => _model.gridSize;
  FixedQueue<Point<int>> get snake => _model.snake;
  Point<int> get food => _model.food;

  void move() {
    _model.move();
    if (_model.state == GameState.collision) {
      _model = GameStateModel();
    }
  }
}
