import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake/bloc/game_bloc.dart';

class Controls extends StatelessWidget {
  final double _iconSize = 48;
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SnakeBloc>();
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => bloc.add(Turn(Direction.up)),
                icon: const Icon(Icons.keyboard_arrow_up),
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => bloc.add(Turn(Direction.left)),
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
            ),
            const Spacer(),
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => bloc.add(Turn(Direction.right)),
                icon: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              child: IconButton(
                iconSize: _iconSize,
                onPressed: () => bloc.add(Turn(Direction.down)),
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
