import 'package:basic_app/screens/market.dart';
import 'package:flutter/material.dart';
import 'screens/change.dart';
import 'screens/leap_year.dart';
import 'screens/perfect_number.dart';
import 'screens/weight.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key});

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  static final List<Widget> _pages = <Widget>[
    MarketScreen(),
    ChangeScreen(),
    LeapYearScreen(),
    PerfectNumberScreen(),
    WeightScreen(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_convenience_store_rounded),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Change',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Leap Year',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Perfect Number',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight),
            label: 'Weight',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.blue[400],
        onTap: _onItemTapped,
      ),
    );
  }
}
