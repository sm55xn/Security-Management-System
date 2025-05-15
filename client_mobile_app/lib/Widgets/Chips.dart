import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class Chips extends StatefulWidget {
  const Chips({super.key});

  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  int tag = 0;
  List<String> options = ["الكل", "البلاغات", "الردود"];
  @override
  Widget build(BuildContext context) {
    
    
    return ChipsChoice<int>.single(
      value: tag,
      onChanged: (val) => setState(() {
        tag = val;
      }),
      choiceItems: C2Choice.listFrom(
          source: options,
           value: (i, v) => i,
           label: (i, v) => v),

      choiceStyle: C2ChipStyle.filled(
        color: Colors.grey[300],

        overlayColor: Colors.green[100],
        selectedStyle:C2ChipStyle(backgroundColor: Colors.green[300]) ,
        borderRadius: BorderRadius.circular(15)),

    );
  }
}
