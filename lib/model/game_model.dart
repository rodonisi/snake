import 'dart:math';

import 'package:snake/helpers/global_logger.dart';
import 'package:snake/utility/fixed_queue.dart';

class GameModel {
  final gridSize = 20;
  final snake = FixedQueue<Point<int>>(1);
  Point<int> food = const Point(0, 0);
  int speed = 200;
  int maxSpeed = 100;
  int speedIncreaseStep = 10;
  GameState state = GameState.none;
  var _direction = Direction.down;

  int get size => snake.queueSize;
  Direction get currentDirection => _direction;
  set currentDirection(Direction direction) {
    if (checkLegalTurn(direction)) {
      _direction = direction;
      logger.d("update direction: $_direction");
    }
    if (state == GameState.none) {
      state = GameState.running;
    }
  }

  GameModel() {
    snake.enqueue(Point(gridSize ~/ 2, gridSize ~/ 2));
    newFood();
  }

  void move() {
    final nextHead = computeNextPoint(currentDirection);
    checkCollision(nextHead);
    checkFood();
  }

  void newFood() {
    food = Point(Random().nextInt(gridSize), Random().nextInt(gridSize));
    logger.d("new food: $food");
  }

  void checkFood() {
    if (snake.contains(food)) {
      newFood();
      snake.queueSize += 1;
      if (speed > maxSpeed) {
        speed -= speed ~/ speedIncreaseStep;
      }
      logger.d("size: $size, speed: $speed");
    }
  }

  void checkCollision(Point<int> newHead) {
    if (snake.contains(newHead) ||
        newHead.x < 0 ||
        newHead.x >= gridSize ||
        newHead.y < 0 ||
        newHead.y >= gridSize) {
      state = GameState.collision;
    } else {
      snake.enqueue(newHead);
    }
  }

  Point<int> computeNextPoint(Direction direction) {
    return snake.head + direction.shift;
  }

  bool checkLegalTurn(Direction direction) {
    final next = computeNextPoint(direction);
    return snake.length < 2 || next != snake.elementAt(1);
  }
}

enum Direction {
  up(Point(0, -1)),
  down(Point(0, 1)),
  left(Point(-1, 0)),
  right(Point(1, 0));

  final Point<int> shift;
  const Direction(this.shift);
}

enum GameState { none, running, collision }
