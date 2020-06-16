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
              child: Stack(
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
                          Color(0xFF3382CC),
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
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        _confirmed == null
                                            ? "No Update"
                                            : _confirmed,
                                        textAlign: TextAlign.right,
                                        style: cHeadingTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 40,
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
                  Stats(),
                ],
              ),
            ),
          )
        : Center(child: new CircularProgressIndicator());
  }
}
