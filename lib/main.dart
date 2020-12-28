import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './News/NewsHome.dart';
import './constVars.dart';
import './Stats/StatsHome.dart';
import './Info/Info.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black87,
    statusBarIconBrightness: Brightness.light,
  ));
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
    Container(),
    NewsHome(),
    Info(),
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
        height: totalHeight * 0.10,
        child: BottomNavigationBar(
          onTap: (index) => onTabTapped(index),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outlined),
              title: Text("Stats"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.place),
              title: Text("Nearby"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.subject),
              title: Text("News"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              title: Text("Info"),
            ),
          ],
        ),
      ),
    );
  }
}
