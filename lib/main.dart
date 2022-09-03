import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/helpers/global_logger.dart';
import 'package:snake/model/game_state_model.dart';
import 'package:snake/widget/game_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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
  final GameStateModel _model = GameStateModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Focus(
        onKey: (node, event) {
          if (event.repeat || event is! RawKeyDownEvent) {
            logger.v("dismissed: $event");
            return KeyEventResult.ignored;
          }

          if (event.physicalKey == PhysicalKeyboardKey.arrowDown ||
              event.physicalKey == PhysicalKeyboardKey.keyS) {
            _model.goDown();
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowUp ||
              event.physicalKey == PhysicalKeyboardKey.keyW) {
            _model.goUp();
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowLeft ||
              event.physicalKey == PhysicalKeyboardKey.keyA) {
            _model.goLeft();
          } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight ||
              event.physicalKey == PhysicalKeyboardKey.keyD) {
            _model.goRight();
          } else {
            return KeyEventResult.ignored;
          }

          return KeyEventResult.handled;
        },
        child: GameBoard(model: _model),
      ),
    );
  }
}
