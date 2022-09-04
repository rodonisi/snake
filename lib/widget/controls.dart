import 'package:flutter/material.dart';
import 'package:snake/controller/game_state_controller.dart';
import 'package:snake/model/game_state_model.dart';

class Controls extends StatelessWidget {
  final double _iconSize = 48;
  final GameStateController controller;
  const Controls({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => controller.currentDirection = Direction.up,
                icon: const Icon(Icons.keyboard_arrow_up),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => controller.currentDirection = Direction.left,
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => controller.currentDirection = Direction.right,
                icon: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => controller.currentDirection = Direction.down,
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            )
          ],
        ),
      ],
    );
  }
}
