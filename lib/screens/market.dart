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
            'In a supermarket, a cashier records the prices of items purchased by customers and tells each customer how much they owe. At the end of the day, he tells his supervisor the total amount charged to all the customers who went through his checkout.',
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
            icon: const Icon(Icons.info),
            onPressed: showHelperPopUp,
          ),
        ],
      ),
      body: const Center(child: Text('Market Screen')),
    );
  }
}
