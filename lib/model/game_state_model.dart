import 'dart:math';

import 'package:snake/helpers/global_logger.dart';
import 'package:snake/utility/fixed_queue.dart';

class GameStateModel {
  final gridSize = 20;
  final snake = FixedQueue<Point<int>>(1);
  Point<int> food = const Point(0, 0);
  int speed = 700;
  int maxSpeed = 100;
  int speedIncreaseStep = 10;

  int get size => snake.queueSize;

  final _opposingDirections = {
    Direction.up: Direction.down,
    Direction.down: Direction.up,
    Direction.left: Direction.right,
    Direction.right: Direction.left,
  };
  var _direction = Direction.none;
  Direction get currentDirection => _direction;
  set currentDirection(Direction direction) {
    if (direction != _opposingDirections[_direction]) {
      _direction = direction;
      logger.d("update direction: $_direction");
    }
  }

  GameState state = GameState.none;

  GameStateModel() {
    snake.enqueue(Point(gridSize ~/ 2, gridSize ~/ 2));
    newFood();
    state = GameState.running;
  }

  void move() {
    var head = snake.head;
    switch (currentDirection) {
      case Direction.up:
        head = Point(head.x, (head.y - 1) % gridSize);
        break;
      case Direction.down:
        head = Point(head.x, (head.y + 1) % gridSize);
        break;
      case Direction.left:
        head = Point((head.x - 1) % gridSize, head.y);
        break;
      case Direction.right:
        head = Point((head.x + 1) % gridSize, head.y);
        break;
      default:
        return;
    }
    checkCollision(head);
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
    if (snake.contains(newHead)) {
      state = GameState.collision;
    } else {
      snake.enqueue(newHead);
    }
  }
}

enum Direction { none, up, down, left, right }

enum GameState { none, running, collision }
