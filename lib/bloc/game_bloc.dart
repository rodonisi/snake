import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snake/helpers/global_logger.dart';
import 'package:snake/utility/fixed_queue.dart';

enum Direction {
  up(Point(0, -1)),
  down(Point(0, 1)),
  left(Point(-1, 0)),
  right(Point(1, 0));

  final Point<int> shift;
  const Direction(this.shift);
}

enum GameState { none, running, collision }

class SnakeEvent {}

class Frame extends SnakeEvent {}

class Turn extends SnakeEvent {
  final Direction direction;
  Turn(this.direction);
}

class SnakeState extends Equatable {
  static const initialSize = 4;
  static const gridSize = 20;
  static const speed = 1000 ~/ 6;

  final GameState state;
  final Direction direction;
  final FixedQueue<Point<int>> snake;
  final Point<int> food;

  bool get foodCollision => snake.contains(food);
  Point<int> get _nextPoint => snake.head + direction.shift;
  int get score => snake.queueSize - initialSize;

  const SnakeState({
    this.snake = const FixedQueue<Point<int>>(queueSize: initialSize),
    this.state = GameState.none,
    this.direction = Direction.down,
    this.food = const Point(0, 0),
  });

  factory SnakeState.initial() {
    return const SnakeState(
      snake: FixedQueue<Point<int>>(
        queueSize: initialSize,
        queue: [
          Point(gridSize ~/ 2, gridSize ~/ 2),
        ],
      ),
    ).placeFood();
  }

  SnakeState copyWith({
    GameState? state,
    Direction? direction,
    int? size,
    FixedQueue<Point<int>>? snake,
    Point<int>? food,
  }) {
    return SnakeState(
      state: state ?? this.state,
      direction: direction ?? this.direction,
      snake: snake ?? this.snake,
      food: food ?? this.food,
    );
  }

  SnakeState placeFood() {
    final food = Point(Random().nextInt(gridSize), Random().nextInt(gridSize));
    logger.d("new food: $food");
    return copyWith(food: food);
  }

  SnakeState increaseSize() {
    return copyWith(snake: snake.copyWith(queueSize: snake.queueSize + 1));
  }

  SnakeState move() {
    if (_isCollision(_nextPoint)) {
      return SnakeState.initial().copyWith(state: GameState.collision);
    }

    logger.d("move: $_nextPoint");
    final newState = _checkFood();
    return newState.placeHead();
  }

  SnakeState placeHead() {
    return copyWith(snake: snake.enqueue(_nextPoint));
  }

  SnakeState turn(Direction direction) {
    if (_checkLegalTurn(direction)) {
      return copyWith(direction: direction, state: GameState.running);
    }
    return this;
  }

  SnakeState _checkFood() {
    if (foodCollision) {
      return placeFood().increaseSize();
    }

    return this;
  }

  bool _isCollision(Point<int> nextHead) {
    return snake.contains(nextHead) ||
        nextHead.x < 0 ||
        nextHead.x >= SnakeState.gridSize ||
        nextHead.y < 0 ||
        nextHead.y >= SnakeState.gridSize;
  }

  bool _checkLegalTurn(Direction direction) {
    final next = snake.head + direction.shift;
    return snake.length < 2 || next != snake.elementAt(1);
  }

  @override
  List<Object> get props => [
        snake,
        state,
        direction,
        food,
      ];
}

class SnakeBloc extends Bloc<SnakeEvent, SnakeState> {
  SnakeBloc() : super(SnakeState.initial()) {
    on<Frame>((event, emit) {
      if (state.state != GameState.none) {
        emit(state.move());
      }
    });

    on<Turn>((event, emit) {
      logger.d("direction: ${event.direction}");
      emit(state.turn(event.direction));
    });

    Timer.periodic(
      const Duration(milliseconds: SnakeState.speed),
      (_) => add(
        Frame(),
      ),
    );
  }
}
