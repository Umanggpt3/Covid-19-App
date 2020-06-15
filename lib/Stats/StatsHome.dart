import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constVars.dart';
import './Stats.dart';

class StatsHome extends StatefulWidget {
  @override
  _StatsHomeState createState() => _StatsHomeState();
}

class _StatsHomeState extends State<StatsHome> {
  String _confirmed;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _confirmed = null;
    _loading = false;
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
        _loading = true;
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
    return _loading
        ? Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 40, right: 20),
                    height: totalHeight * 0.40,
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
                  Column(
                    children: <Widget>[
                      Stats(),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Prevention",
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
                          height: totalHeight * 0.13,
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
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/icons/mask.svg',
                                      width: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Wear\nMask",
                                    )
                                  ],
                                ),
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
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/icons/glove.svg',
                                      width: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Wear\nGloves"),
                                  ],
                                ),
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
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/icons/social-distance.svg',
                                      width: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Social\nDistancing"),
                                  ],
                                ),
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
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/icons/wash-hands.svg',
                                      width: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Wash\nHands"),
                                  ],
                                ),
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
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/icons/sanitizer.svg',
                                      width: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Use\nSanitizer"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Center(child: new CircularProgressIndicator());
  }
}
