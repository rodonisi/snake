import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake/controller/game_view_model.dart';

class Score extends StatelessWidget {
  const Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var score = context.select<GameNotifier, int>(
      (value) => value.score,
    );
    return Text("Score: $score");
  }
}
