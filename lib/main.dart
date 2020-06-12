import 'package:flutter/material.dart';

import './constVars.dart';
import './Stats/StatsHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19 App',
      theme: ThemeData(
          scaffoldBackgroundColor: lightBgColor,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyText2: TextStyle(color: bodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    StatsHome(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: totalHeight * 0.071,
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outlined),
              title: Container(),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.place),
              title: Container(),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.subject),
              title: Container(),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              title: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
