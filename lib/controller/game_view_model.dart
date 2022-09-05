import 'dart:math';

import 'package:snake/helpers/global_logger.dart';
import 'package:snake/model/game_model.dart';
import 'package:snake/utility/fixed_queue.dart';

class GameViewModel {
  var _model = GameModel();

  Direction get currentDirection => _model.currentDirection;
  set currentDirection(Direction direction) =>
      _model.currentDirection = direction;
  int get speed => _model.speed;
  int get gridSize => _model.gridSize;
  FixedQueue<Point<int>> get snake => _model.snake;
  Point<int> get food => _model.food;

  void refresh() {
    if (_model.state == GameState.running) {
      _model.move();
    } else if (_model.state == GameState.collision) {
      logger.d("restart game");
      _model = GameModel();
    }
  }
}