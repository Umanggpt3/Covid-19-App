import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constVars.dart';

class PreventionItem extends StatelessWidget {
  final String svgPath;
  final String svgText;

  PreventionItem(this.svgPath, this.svgText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 3),
                blurRadius: 5,
                color: bodyTextColor.withOpacity(0.1))
          ]),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            svgPath,
            width: 45,
          ),
          SizedBox(
            width: 10,
          ),
          Text(svgText, style: cSubTextStyle.copyWith(color: bodyTextColor.withOpacity(0.7),),),
        ],
      ),
    );
  }
}
