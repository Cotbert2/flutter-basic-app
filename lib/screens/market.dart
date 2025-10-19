import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  //logic

  void showHelperPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exercise Description #11'),
          content: const Text(
            'A year is a leap year if it is a multiple of 4, except for multiples of 100, which are only leap years when they are also multiples of 400, for example the year 1900 was not a leap year, but the year 2000 was. Make a program that, given a year A, tells us if it is a leap year or not',
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

  //view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: showHelperPopUp,
          ),
        ],
      ),
      body: const Center(child: Text('Market Screen')),
    );
  }
}
