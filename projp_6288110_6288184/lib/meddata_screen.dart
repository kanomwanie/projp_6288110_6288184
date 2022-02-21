import 'package:flutter/material.dart';

class Meddata extends StatelessWidget {
  const Meddata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2
      appBar: AppBar(
        title: const Text('DailyMeds'),
      ),
      // 3
      body: const Center(
        child: Text('Hello World med'),
      ),
    );
  }
}