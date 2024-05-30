import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:snake/board.dart';
import 'package:snake/constants.dart';
import 'package:snake/snake.dart';
import 'package:snake/tile.dart';

enum PlayState { none, playing, gameOver }

class SnakeGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  PlayState _playState = PlayState.none;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.gameOver:
        world.removeWhere((element) => element is Food);
        overlays.add(playState.name);
      case PlayState.none:
      case PlayState.playing:
        overlays.remove(PlayState.gameOver.name);
    }
  }

  SnakeGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: Constants.worldSize.x,
            height: Constants.worldSize.y,
          ),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(Board());
    start();
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (playState != PlayState.playing &&
        keysPressed.any((element) =>
            element == LogicalKeyboardKey.arrowDown ||
            element == LogicalKeyboardKey.arrowUp ||
            element == LogicalKeyboardKey.arrowLeft ||
            element == LogicalKeyboardKey.arrowRight)) {
      start();
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void start() {
    if (playState == PlayState.playing) {
      return;
    }
    playState = PlayState.playing;
    world.add(Snake());
    placeFood();
  }

  void eat() {
    world.firstChild<Snake>()?.length++;
    placeFood();
  }

  void placeFood() {
    final x =
        Random().nextInt(Constants.gridSize.toInt()) * Constants.tileSize +
            Constants.gutter;
    final y =
        Random().nextInt(Constants.gridSize.toInt()) * Constants.tileSize +
            Constants.gutter;
    world.add(Food()..position = Vector2(x.toDouble(), y.toDouble()));
  }
}
