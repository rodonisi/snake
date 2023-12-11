import 'package:flutter/material.dart';

class SnakeTile extends StatelessWidget {
  const SnakeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 2.0,
      margin: EdgeInsets.all(1.0),
      color: Colors.blue,
    );
  }
}
