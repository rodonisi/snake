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

Future<void> move(Direction currentDirection, LogicalKeyboardKey newDirection,
    WidgetTester tester) async {
  if (opposites[newDirection] == currentDirection) {
    await tester.sendKeyEvent(sideMoves[currentDirection]!);
    await tester.pump();
  }
  await tester.sendKeyEvent(newDirection);
}

Future<void> computeMove(WidgetTester tester, SnakeBloc bloc) async {
  final food = bloc.state.food;
  final head = bloc.state.snake.first;
  final currentDirection = bloc.state.direction;

  if (head.x < food.x) {
    await move(currentDirection, LogicalKeyboardKey.arrowRight, tester);
  } else if (head.x > food.x) {
    await move(currentDirection, LogicalKeyboardKey.arrowLeft, tester);
  } else if (head.y < food.y) {
    await move(currentDirection, LogicalKeyboardKey.arrowDown, tester);
  } else if (head.y > food.y) {
    await move(currentDirection, LogicalKeyboardKey.arrowUp, tester);
  }
  await tester.pump();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("play one match", (tester) async {
    final bloc = SnakeBloc();
    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: const MyApp(),
      ),
    );

    while (bloc.state.state != GameState.collision) {
      await computeMove(tester, bloc);
    }
  });
}
