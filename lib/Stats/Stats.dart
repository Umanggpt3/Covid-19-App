import '../constVars.dart';
import './Cases.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final stateList = [
    "India",
    "Andaman and Nicobar Islands",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Ladakh",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
  ];

  Cases _futureState;
  String dropDownValue = "India";

  @override
  void initState() {
    super.initState();
    _futureState = null;
    _fetchStats("Total");
  }

  _fetchStats(String state) async {
    final response = await http.get('https://api.covid19india.org/data.json');

    if (response.statusCode == 200) {
      var r = json.decode(response.body);
      var res = r["statewise"];
      res.forEach((item) {
        if (item["state"] == state) {
          String active = item["active"];
          String confirmed = item["confirmed"];
          String deaths = item["deaths"];
          String recovered = item["recovered"];
          String deltaConfirmed = item["deltaconfirmed"];
          String deltaDeaths = item["deltadeaths"];
          String deltaRecovered = item["deltarecovered"];
          DateTime formattedDate =
              new DateFormat('d/M/yyyy H:m:s').parse(item["lastupdatedtime"]);
          setState(() {
            _futureState = Cases(state, active, confirmed, deaths, recovered,
                formattedDate, deltaConfirmed, deltaDeaths, deltaRecovered);
          });
        }
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    // _fetchStats("Total");
    final totalHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final totalWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: totalHeight * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cShadowColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset('assets/icons/maps-and-flags.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                      value: dropDownValue,
                      items:
                          stateList.map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem<String>(
                          child: Text(val),
                          value: val,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if(value == "India") {
                            dropDownValue = value;
                            value = "Total";
                          } else {
                            dropDownValue = value;
                          }
                        });
                        _fetchStats(value);
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: cTitleTextstyle,
                            ),
                            TextSpan(
                              text: _futureState != null
                                  ? 'Newest Update on ${new DateFormat.yMMMd().format(_futureState.dateTime)}'
                                  : 'No Update',
                              style: TextStyle(
                                color: textLightColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: totalHeight * 0.20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: lightBgColor)
                  ]),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: totalWidth * 0.275,
                        margin: EdgeInsets.symmetric(
                            horizontal: totalWidth * 0.019),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: lightBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: infectedColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/running.svg',
                                height: 15,
                                width: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _futureState != null
                                  ? '${_futureState.confirmed}'
                                  : 'No Update',
                              style: TextStyle(
                                color: infectedColor,
                                fontSize: totalWidth * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Confirmed",
                              style: TextStyle(
                                color: infectedColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: totalWidth * 0.28,
                        margin:
                            EdgeInsets.symmetric(horizontal: totalWidth * 0.02),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: lightBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: deathColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/running.svg',
                                height: 15,
                                width: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _futureState != null
                                  ? '${_futureState.deaths}'
                                  : 'No Update',
                              style: TextStyle(
                                color: deathColor,
                                fontSize: totalWidth * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Deaths",
                              style: TextStyle(
                                color: deathColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: totalWidth * 0.28,
                        margin:
                            EdgeInsets.symmetric(horizontal: totalWidth * 0.02),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: lightBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: recoverColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/running.svg',
                                height: 15,
                                width: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _futureState != null
                                  ? '${_futureState.recovered}'
                                  : 'No Update',
                              style: TextStyle(
                                color: recoverColor,
                                fontSize: totalWidth * 0.05,
                              ),
                            ),
                            Text(
                              "Recovered",
                              style: TextStyle(
                                color: recoverColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
