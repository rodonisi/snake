import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake/controller/game_view_model.dart';
import 'package:snake/model/game_model.dart';

class Controls extends StatelessWidget {
  final double _iconSize = 48;
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<GameNotifier>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => viewModel.direction = Direction.up,
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
                onPressed: () => viewModel.direction = Direction.left,
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => viewModel.direction = Direction.right,
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
                onPressed: () => viewModel.direction = Direction.down,
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            )
          ],
        ),
      ],
    );
  }
}
