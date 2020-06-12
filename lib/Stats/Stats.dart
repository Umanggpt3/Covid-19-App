import '../constVars.dart';
import './Cases.dart';
import './EachType.dart';
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
          String active = item["active"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          String confirmed = item["confirmed"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          String deaths = item["deaths"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          String recovered = item["recovered"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          String deltaConfirmed = item["deltaconfirmed"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          String deltaDeaths = item["deltadeaths"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          String deltaRecovered = item["deltarecovered"].replaceAllMapped(
              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
          DateTime formattedDate =
              new DateFormat('d/M/yyyy H:m:s').parse(item["lastupdatedtime"]);
          String deltaActive = (int.parse(item["deltaconfirmed"]) -
                  int.parse(item["deltadeaths"]) -
                  int.parse(item["deltarecovered"]))
              .toString()
              .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},');
          setState(() {
            _futureState = Cases(
                state,
                active,
                confirmed,
                deaths,
                recovered,
                formattedDate,
                deltaConfirmed,
                deltaDeaths,
                deltaRecovered,
                deltaActive);
          });
        }
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
    return SingleChildScrollView(
      child: Container(
        height: totalHeight * 0.77,
        transform: Matrix4.translationValues(0.0, totalHeight * 0.18, 0.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
                          if (value == "India") {
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
              height: 50,
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
                              text: "Latest Update\n",
                              style: cTitleTextstyle,
                            ),
                            TextSpan(
                              text: _futureState != null
                                  ? 'on ${new DateFormat.yMMMd().format(_futureState.dateTime)}'
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
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: totalHeight * 0.40,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      EachType(
                        deltaCount: _futureState.deltaConfirmed,
                        count: _futureState.confirmed,
                        color: infectedColor,
                        text: "Confirmed"
                      ),
                      EachType(
                        deltaCount: _futureState.deltaActive,
                        count: _futureState.active,
                        color: activeColor,
                        text: "Active"
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        EachType(
                          deltaCount: _futureState.deltaDeaths,
                          count: _futureState.deaths,
                          color: deathColor,
                          text: "Deaths"
                        ),
                        EachType(
                          deltaCount: _futureState.deltaRecovered,
                          count: _futureState.recovered,
                          color: recoverColor,
                          text: "Recovered"
                        ),
                      ],
                    ),
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
