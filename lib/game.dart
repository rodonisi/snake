import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:snake/board.dart';
import 'package:snake/constants.dart';
import 'package:snake/snake.dart';

class SnakeGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
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

    world.add(Snake());

    debugMode = true;
  }
}

class Block {
  final Vector2 position;
  final Type type;

  Block(this.position, this.type);
}
