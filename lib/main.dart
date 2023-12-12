import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/bloc/game_bloc.dart';
import 'package:snake/widget/controls.dart';
import 'package:snake/widget/game_board.dart';
import 'package:snake/widget/score.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers/platform_helpers.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => SnakeBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
            context.read<SnakeBloc>().add(
                  Turn(Direction.down),
                ),
        const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
            context.read<SnakeBloc>().add(
                  Turn(Direction.up),
                ),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            context.read<SnakeBloc>().add(
                  Turn(Direction.left),
                ),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            context.read<SnakeBloc>().add(
                  Turn(Direction.right),
                ),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Score(),
          ),
          body: SafeArea(
            bottom: true,
            child: Column(
              children: [
                const Flexible(
                  child: Center(
                    child: Card(
                      margin: EdgeInsets.all(16.0),
                      child: GameBoard(),
                    ),
                  ),
                ),
                if (isMobile) ...[
                  const Controls(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
