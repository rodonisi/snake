import 'dart:collection';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:snake/bloc/game_bloc.dart';
import 'package:snake/main.dart';

final opposites = {
  LogicalKeyboardKey.arrowUp: Direction.down,
  LogicalKeyboardKey.arrowDown: Direction.up,
  LogicalKeyboardKey.arrowLeft: Direction.right,
  LogicalKeyboardKey.arrowRight: Direction.left,
};

final sideMoves = {
  Direction.up: LogicalKeyboardKey.arrowLeft,
  Direction.down: LogicalKeyboardKey.arrowRight,
  Direction.left: LogicalKeyboardKey.arrowDown,
  Direction.right: LogicalKeyboardKey.arrowUp,
};

final directionKeys = {
  Direction.up: LogicalKeyboardKey.arrowUp,
  Direction.down: LogicalKeyboardKey.arrowDown,
  Direction.left: LogicalKeyboardKey.arrowLeft,
  Direction.right: LogicalKeyboardKey.arrowRight,
};

final shiftToDirection = {
  const Point(0, -1): Direction.up,
  const Point(0, 1): Direction.down,
  const Point(-1, 0): Direction.left,
  const Point(1, 0): Direction.right,
};

// Function to find the shortest path using BFS
List<Point<int>>? bfs(SnakeState state, {Point<int>? override}) {
  const width = SnakeState.gridSize;
  const height = SnakeState.gridSize;
  final start = state.snake.first;
  final end = override ?? state.food;
  final obstacles = state.snake.toSet();
  final visited = <Point<int>>{};
  final queue = Queue<List<Point<int>>>();

  if (start == end) {
    return null;
  }

  queue.add([start]);

  while (queue.isNotEmpty) {
    final path = queue.removeFirst();
    final current = path.last;

    if (current == end) {
      return path;
    }

    for (final direction in Direction.values) {
      final neighbor = current + direction.shift;

      if (neighbor.x >= 0 &&
          neighbor.x < width &&
          neighbor.y >= 0 &&
          neighbor.y < height &&
          !obstacles.contains(neighbor) &&
          !visited.contains(neighbor)) {
        queue.add(List.from(path)..add(neighbor));
        visited.add(neighbor);
      }
    }
  }

  return null;
}

// Function to find the shortest path using BFS
List<Point<int>> findPath(SnakeState state) {
  const width = SnakeState.gridSize;
  const height = SnakeState.gridSize;
  final start = state.snake.first;
  final obstacles = state.snake.toSet();

  final path = bfs(state) ??
      bfs(
        state,
        override: const Point(0, 0),
      ) ??
      bfs(
        state,
        override: const Point(SnakeState.gridSize - 1, SnakeState.gridSize - 1),
      ) ??
      bfs(
        state,
        override: const Point(0, SnakeState.gridSize - 1),
      ) ??
      bfs(
        state,
        override: const Point(SnakeState.gridSize - 1, 0),
      );

  if (path != null) {
    return path;
  }

  // Don't die
  for (final direction in Direction.values) {
    final neighbor = start + direction.shift;
    if (neighbor.x >= 0 &&
        neighbor.x < width &&
        neighbor.y >= 0 &&
        neighbor.y < height &&
        !obstacles.contains(neighbor)) {
      return [start, neighbor];
    }
  }

  return []; // Cannot be saved
}

LogicalKeyboardKey? computeMove(List<Point<int>> path) {
  if (path.length < 2) {
    return null;
  }

  final current = path.first;
  final next = path[1];
  final shift = next - current;
  return directionKeys[shiftToDirection[shift]]!;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("play three matches", (tester) async {
    final bloc = SnakeBloc();
    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: const MyApp(),
      ),
    );

    var count = 0;
    while (count < 3) {
      final path = findPath(bloc.state);
      final move = computeMove(path);
      if (move != null) {
        await tester.sendKeyEvent(move);
      }
      await tester.pump();
      if (bloc.state.state == GameState.none) {
        count++;
      }
    }
  });
}
