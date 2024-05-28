import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/widgets.dart';

class Snake extends PositionComponent with KeyboardHandler {
  Vector2 direction = Vector2(0, 0);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = const Color(0xFFFF00FF));
  }

  void move() {
    position.add(direction);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        direction = Vector2(0, -size.y);
        return true;
      case LogicalKeyboardKey.arrowDown:
        direction = Vector2(0, size.y);
        return true;
      case LogicalKeyboardKey.arrowLeft:
        direction = Vector2(-size.x, 0);
        return true;
      case LogicalKeyboardKey.arrowRight:
        direction = Vector2(size.x, 0);
        return true;
      default:
        return super.onKeyEvent(event, keysPressed);
    }
  }
}

class Game extends FlameGame with HasKeyboardHandlerComponents {
  late Snake snake;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    snake = Snake()
      ..position = size / 2
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center;

    add(snake);

    add(TimerComponent(
      period: 0.2,
      repeat: true,
      onTick: () => snake.move(),
    ));
  }
}

void main() {
  runApp(
    GameWidget(
      game: Game(),
    ),
  );
}
