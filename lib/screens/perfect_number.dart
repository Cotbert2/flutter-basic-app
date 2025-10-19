import 'package:flutter/material.dart';
import './../core/perfect_number.dart';

class PerfectNumberScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PerfectNumberScreenState();
}

class _PerfectNumberScreenState extends State<PerfectNumberScreen> {
  //logic

  final TextEditingController _numberController = TextEditingController();
  String message = '';

  void showHelperPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exercise Description #11'),
          content: const Text(
            'In a supermarket, a cashier captures the prices of the items that customers buy and tells each customer the amount they have to pay. At the end of the day, he/she tells their supervisor the total amount charged to all the customers who passed through their checkout',
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

  void checkPerfectNumber() {
    final number = int.tryParse(_numberController.text) ?? 0;

    setState(() {
      message = PerfectNumber.isPerfect(number)
          ? '$number is a perfect number.'
          : '$number is not a perfect number.';
    });
  }

  //view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Perfect Number'),
        actions: [
          IconButton(icon: const Icon(Icons.info), onPressed: showHelperPopUp),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Icon(Icons.check_circle, size: 200.0, color: Colors.blue),
            ),
            SizedBox(height: 40.0),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a year',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                labelStyle: TextStyle(color: Colors.blue),
              ),
              keyboardType: TextInputType.number,
              controller: _numberController,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: checkPerfectNumber,
              child: const Text('Check Leap Year'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,

                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 40.0),
            Center(
              child: Text(
                message,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
