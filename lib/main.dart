import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snake/controller/game_view_model.dart';
import 'package:snake/helpers/platform_helpers.dart';
import 'package:snake/model/game_model.dart';
import 'package:snake/widget/controls.dart';
import 'package:snake/widget/game_board.dart';
import 'package:snake/widget/score.dart';

void main() {
  final game = GameNotifier();
  game.start();
  runApp(ChangeNotifierProvider.value(
    value: game,
    child: const MyApp(),
  ));
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var notifier = context.read<GameNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Score(),
      ),
      body: Focus(
        onKey: (node, event) {
          if (event.repeat || event is! RawKeyDownEvent) {
            return KeyEventResult.ignored;
          }

          if (event.physicalKey == PhysicalKeyboardKey.arrowDown ||
              event.physicalKey == PhysicalKeyboardKey.keyS) {
            notifier.direction = Direction.down;
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowUp ||
              event.physicalKey == PhysicalKeyboardKey.keyW) {
            notifier.direction = Direction.up;
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowLeft ||
              event.physicalKey == PhysicalKeyboardKey.keyA) {
            notifier.direction = Direction.left;
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight ||
              event.physicalKey == PhysicalKeyboardKey.keyD) {
            notifier.direction = Direction.right;
          } else {
            return KeyEventResult.ignored;
          }

          return KeyEventResult.handled;
        },
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              const GameBoard(),
              if (isMobile) ...[
                const Spacer(),
                const Controls(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
