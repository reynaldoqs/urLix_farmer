import 'package:flutter/material.dart';
import 'package:urlix_farmer/core/utilities/dateOpts.dart';
import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;

class DateInformation extends StatelessWidget {
  const DateInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle mainTextStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: xColors.textDark3);

    return SizedBox(
        height: 140,
        width: 100,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: xColors.textDark3, width: 2.5),
                  ),
                  child: Text(
                    getFormatedDate(DateTime.now()),
                    style: mainTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
