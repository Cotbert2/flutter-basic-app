import 'package:flutter/material.dart';

class ChangeScreen extends StatelessWidget {
  const ChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Change'),
      ),
      body: const Center(
        child: Text('Change Screen'),
      ),
    );
  }
}
