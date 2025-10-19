import 'package:flutter/material.dart';
import './../core/change.dart';

class ChangeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  final productPriceController = TextEditingController();
  final amountPaidController = TextEditingController();

  String changeDue = '';
  String changeBreakdown = '';

  void computeChange() {
    //just two decimal places

    final price = double.tryParse(productPriceController.text) ?? 0.0;
    final amountPaid = double.tryParse(amountPaidController.text) ?? 0.0;

    print('Price: $price, Amount Paid: $amountPaid');

    setState(() {
      if (amountPaid < price) {
        this.changeBreakdown = 'Insufficient amount paid';
        return;
      }

      if (amountPaid == price) {
        this.changeBreakdown = 'No change due';
        return;
      }

      if (price <= 0) {
        this.changeBreakdown = 'Invalid product price';
        return;
      }

      if (amountPaid <= 0) {
        this.changeBreakdown = 'Invalid amount paid';
        return;
      }

      Change.resetChange();
      Change.computeChange(
          double.parse((amountPaid - price).toStringAsFixed(2)) //this avoid floating point issue
      );

      this.changeBreakdown = 'table';
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Change'),
        actions: [
          IconButton(icon: const Icon(Icons.info), onPressed: showHelperPopUp),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: productPriceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Price',
                // //blue outline when focused
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 50.0),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountPaidController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount Paid',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                //blue outline text when focused
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),

            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: computeChange,
              child: Text('Compute Change'),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,

                foregroundColor: Colors.white,
              ),
            ),

            SizedBox(height: 50.0),
             ...[
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.blue),
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Coin', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                          )),
                      )),
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Count', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                      )),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$2.00'),
                      )),
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${Change.twoDollarCoins}'),
                      )),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$1.00'),
                      )),
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${Change.oneDollarCoins}'),
                      )),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$0.50'),
                      )),
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${Change.fiftyCentsCoins}'),
                      )),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$0.25'),
                      )),
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${Change.quarterCoins}'),
                      )),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('\$0.10'),
                      )),
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${Change.dimeCoins}'),
                      )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Center( 
                child: Text(
                  'Pending Amount: \$${Change.pendingAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ] 
          ],
        ),
      ),
    );
  }
}
