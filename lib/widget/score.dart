import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake/bloc/game_bloc.dart';

class Score extends StatelessWidget {
  const Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SnakeBloc, SnakeState, int>(
      selector: (state) => state.score,
      builder: (context, state) {
        return Text("Score: $state");
      },
    );
  }
}
