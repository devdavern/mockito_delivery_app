// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/font_styles.dart';

enum DishCounterSize { normal, mini }

class DishCounter extends StatefulWidget {
  final void Function(int) onChanged;
  final DishCounterSize size;
  final int initialValue;
  const DishCounter({
    Key? key,
    required this.onChanged,
    this.size = DishCounterSize.normal,
    this.initialValue = 0,
  }) : //assert(size != null),
        //assert(initialValue >= 0),
        super(key: key);

  @override
  _DishCounterState createState() => _DishCounterState();
}

class _DishCounterState extends State<DishCounter> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _updateCounter(int counter) {
    if (counter >= 0) {
      _counter = counter;
      setState(() {});
      widget.onChanged(_counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool mini = widget.size == DishCounterSize.mini;

    final double padding = mini ? 5 : 10;
    final double fontSize = mini ? 33 : 44;

    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            minSize: 22,
            borderRadius: BorderRadius.circular(30),
            onPressed: () => _updateCounter(_counter - 1),
            color: const Color(0xffd7ccc8),
            padding: EdgeInsets.all(padding),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 20),
          Text(
            "$_counter",
            style: MyFontStyles.title.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 20),
          CupertinoButton(
            minSize: 22,
            borderRadius: BorderRadius.circular(30),
            onPressed: () => _updateCounter(_counter + 1),
            color: const Color(0xffd7ccc8),
            padding: EdgeInsets.all(padding),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
