import 'package:flutter/material.dart';

class LeapYearScreen extends StatelessWidget {
  const LeapYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Leap Year'),
      ),
      body: const Center(
        child: Text('Leap Year Screen'),
      ),
    );
  }
}
