import 'dart:math';

import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final _emojis =
      'ððððððððððŦððððĨ­ððĨĨðĨðððĨðĨĶðĨŽðĨðķðŦð―ðĨðŦð§ð§ðĨð ðĨðĨŊððĨðĨĻð§ðĨðģð§ðĨð§ðĨðĨĐðððĶīð­ððððŦðĨŠðĨð§ðŪðŊðŦðĨðĨðŦðĨŦðððēððĢðąðĨðĶŠðĪððððĨðĨ ðĨŪðĒðĄð§ðĻðĶðĨ§ð§ð°ððŪð­ðŽðŦðŋðĐðŠð°ðĨðŊðĨðžðŦâïļðĩð§ðĨĪð§ðķðšðŧðĨð·ðĨðļðđð§ðūð§ðĨðīð―ðĨĢðĨĄðĨĒð§';
  const FoodTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chars = Characters(_emojis);
    final index = Random().nextInt(chars.length);
    return FittedBox(
      fit: BoxFit.fill,
      child: Center(
        child: Text(
          chars.elementAt(index),
        ),
      ),
    );
  }
}
