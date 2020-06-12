import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './constVars.dart';
import './Stats/Stats.dart';

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
  String _confirmed;

  @override
  void initState() {
    super.initState();
    _confirmed = null;
    _fetchStats();
  }

  _fetchStats() async {
    final response = await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      var r = json.decode(response.body);
      var res = r["Global"];
      String confirmed = res["TotalConfirmed"].toString().replaceAllMapped(
          new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

      setState(() {
        _confirmed = confirmed;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 40, right: 20),
              height: totalHeight * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/virus.png'),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset('assets/icons/menu.svg'),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: SvgPicture.asset(
                            'assets/icons/Drcorona.svg',
                            width: totalWidth * 0.6,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Worldwide Cases',
                                  textAlign: TextAlign.right,
                                  style: cHeadingTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                if (_confirmed != null)
                                  Text(
                                    _confirmed == null
                                        ? "No Update"
                                        : _confirmed,
                                    style: cHeadingTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Stats(),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Requirements",
                      style: cTitleTextstyle,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      "More",
                      style: TextStyle(color: bodyTextColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: totalHeight * 0.15,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  color: bodyTextColor.withOpacity(0.1))
                            ]),
                        child: SvgPicture.asset('assets/icons/mask.svg'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  color: bodyTextColor.withOpacity(0.1))
                            ]),
                        child: SvgPicture.asset('assets/icons/glove.svg'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  color: bodyTextColor.withOpacity(0.1))
                            ]),
                        child: SvgPicture.asset('assets/icons/social-distance.svg'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  color: bodyTextColor.withOpacity(0.1))
                            ]),
                        child: SvgPicture.asset('assets/icons/wash-hands.svg'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  color: bodyTextColor.withOpacity(0.1))
                            ]),
                        child: SvgPicture.asset('assets/icons/sanitizer.svg'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
