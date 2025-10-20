import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  void showHelperPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exercise Description #15'),
          content: const Text(
            'Five members of an anti-obesity club want to know how much weight they have lost or gained since the last time they met. To do this, they must perform a weigh-in ritual, where each member weighs themselves on ten different scales to obtain the most accurate average of their weight. If there is a positive difference between this average weight and the weight from the last time they met, it means they have gained weight. But if the difference is negative, it means they have lost weight. The problem requires that each member be given a sign that says "GAINED" or "LOST" and the number of kilos they have gained or lost.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Weight'),
        actions: [
          IconButton(icon: const Icon(Icons.info), onPressed: showHelperPopUp),
        ],
      ),
      body: const Center(
        child: Text('Weight Screen'),
      ),
    );
  }
}
