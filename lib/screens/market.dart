import 'package:flutter/material.dart';
import '../core/basic_store.dart';

class MarketScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final BasicStore store = BasicStore();
  List<double> currentItems = [];
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  void addItem() {
    final price = double.tryParse(priceController.text);
    if (price != null && price > 0 && price <= 1000000) {
      setState(() {
        currentItems.add(price);
        priceController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid price')),
      );
    }
  }

  double getCurrentTotal() {
    return currentItems.fold(0.0, (sum, price) => sum + price);
  }

  void checkoutCustomer() {
    if (currentItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No items added for this customer')),
      );
      return;
    }

    final total = getCurrentTotal();
    store.addCustomerTotal(total);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Customer Total'),
          content: Text(
            'Customer owes: \$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentItems.clear();
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDayReport() {
    if (store.getCustomerCount() == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No customers served today')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('End of Day Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total amount: \$${store.getGrandTotal().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              Text('Total customers: ${store.getCustomerCount()}'),
              const SizedBox(height: 15),
              const Text(
                'Customers:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              ...store.customerTotals.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'Customer ${entry.key + 1}: \$${entry.value.toStringAsFixed(2)}',
                  ),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  store.reset();
                  currentItems.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Store reset for new day')),
                );
              },
              child: const Text(
                'Reset Day',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

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
              child: const Text('Close', style: TextStyle(color: Colors.blue)),
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
        title: const Text('Basic Flutter App: Market'),
        actions: [
          IconButton(icon: const Icon(Icons.info), onPressed: showHelperPopUp),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Current Customer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: priceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Item Price',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.blue,
                      ), // label cuando flota
                    ),
                    onSubmitted: (_) => addItem(),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: addItem,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: currentItems.isEmpty
                          ? const Center(child: Text('No items added yet'))
                          : ListView.builder(
                              itemCount: currentItems.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '\$${currentItems[index].toStringAsFixed(2)}',
                                  ),
                                );
                              },
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black38)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Current Customer Total: \$${getCurrentTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: currentItems.isEmpty ? null : checkoutCustomer,
                  label: const Text('Checkout Customer'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: showDayReport,
                  label: const Text('Day Report'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
