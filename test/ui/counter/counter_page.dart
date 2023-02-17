import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("$counter"),
          TextButton(
            key: const Key('tmp'),
            onPressed: () {},
            child: const Text("TMP"),
          ),
          TextButton(
            key: const Key('add'),
            onPressed: () {
              counter++;
              setState(() {});
            },
            child: const Text("ADD"),
          ),
        ],
      ),
    );
  }
}
