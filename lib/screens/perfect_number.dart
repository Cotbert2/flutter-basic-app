import 'package:flutter/material.dart';

class PerfectNumberScreen extends StatelessWidget {
  const PerfectNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Perfect Number'),
      ),
      body: const Center(
        child: Text('Perfect Number Screen'),
      ),
    );
  }
}
