import 'package:flutter/material.dart';
import './../core/leap.dart';

class LeapYearScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeapYearScreenState();
}

class _LeapYearScreenState extends State<LeapYearScreen> {
  //logic

  final TextEditingController _yearController = TextEditingController();
  String message = '';

  void checkLeapYear() {
    final year = int.tryParse(_yearController.text) ?? 0;

    setState(() {
      if (year <= 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Please enter a valid positive year.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
      message = Leap.isLeapYear(year)
          ? '$year is a leap year.'
          : '$year is not a leap year.';
    });
  }

  void showHelperPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exercise Description #13'),
          content: const Text(
            'A year is a leap year if it is a multiple of 4, except for multiples of 100, which are only leap years when they are also multiples of 400, for example the year 1900 was not a leap year, but the year 2000 was. Make a program that, given a year A, tells us if it is a leap year or not',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
        title: const Text('Basic Flutter App: Leap Year'),
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
              child: Icon(
                Icons.calendar_today,
                size: 200.0,
                color: Colors.blue,
              ),
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
              controller: _yearController,
            ),

            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: checkLeapYear,
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
