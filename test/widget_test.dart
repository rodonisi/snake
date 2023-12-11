import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snake/bloc/game_bloc.dart';
import 'package:snake/utility/fixed_queue.dart';
import 'package:snake/widget/board_tile.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:snake/widget/food_tile.dart';
import 'package:snake/widget/snake_tile.dart';

class MockSnakeBloc extends MockBloc<SnakeEvent, SnakeState>
    implements SnakeBloc {}

class MockSnakeState extends Mock implements SnakeState {}

void main() {
  late SnakeBloc bloc;
  late SnakeState state;

  setUp(() {
    bloc = MockSnakeBloc();
    state = MockSnakeState();
    when(() => bloc.state).thenReturn(state);
  });

  testWidgets('when point is neither snake nor food then is just container',
      (tester) async {
    const point = Point(0, 0);
    when(() => state.snake)
        .thenReturn(const FixedQueue<Point<int>>(queueSize: 0));
    when(() => state.food).thenReturn(const Point(1, 1));

    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: const BoardTile(point: point),
      ),
    );

    expect(find.byType(Container), findsOneWidget);
  });

  testWidgets('when point is food then food tile is expected', (tester) async {
    const point = Point(0, 0);
    when(() => state.snake)
        .thenReturn(const FixedQueue<Point<int>>(queueSize: 0));
    when(() => state.food).thenReturn(point);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: const BoardTile(point: point),
        ),
      ),
    );

    expect(find.byType(FoodTile), findsOneWidget);
  });

  testWidgets('when point is in snake then snake tile is expected',
      (tester) async {
    const point = Point(0, 0);
    when(() => state.snake).thenReturn(
      const FixedQueue<Point<int>>(
        queueSize: 1,
        queue: [point],
      ),
    );
    when(() => state.food).thenReturn(const Point(1, 1));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: const BoardTile(point: point),
        ),
      ),
    );

    expect(find.byType(SnakeTile), findsOneWidget);
  });
}
