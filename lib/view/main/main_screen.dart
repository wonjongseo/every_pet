import 'package:every_pet/view/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> body = [HomeScreen(), Text('栄養画面'), Text('費用画面'), Text('設定画面')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            currentIndex: pageIndex,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: tapBottomNavigatoinBar,
            items: const [
              BottomNavigationBarItem(
                label: 'カレンダー',
                icon: Icon(Icons.calendar_month),
              ),
              BottomNavigationBarItem(
                label: '栄養',
                icon: Icon(Icons.health_and_safety),
              ),
              BottomNavigationBarItem(
                label: '費用',
                icon: Icon(Icons.money),
              ),
              BottomNavigationBarItem(
                label: '設定',
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          Container(
            height: 80,
            width: double.infinity,
            child: Text(
              'This is AD',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            color: Colors.yellow,
          ),
        ],
      ),
      body: SafeArea(child: body[pageIndex]),
    );
  }

  void tapBottomNavigatoinBar(value) {
    pageIndex = value;
    setState(() {});
  }
}
