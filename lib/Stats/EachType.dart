import '../constVars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EachType extends StatelessWidget {
  final String count;
  final String deltaCount;
  final Color color;
  final String text;

  EachType({this.deltaCount, this.count, this.color, this.text});

  @override
  Widget build(BuildContext context) {
    final totalHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final totalWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          width: totalWidth * 0.45,
          margin: EdgeInsets.symmetric(horizontal: totalWidth * 0.02),
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
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.75),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/running.svg',
                      color: Colors.white,
                      height: 15,
                      width: 15,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.trending_up,
                    color: color,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    deltaCount,
                    style: TextStyle(
                      color: color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                count != null
                    ? '$count'
                    : 'No Update',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: totalWidth * 0.08,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
