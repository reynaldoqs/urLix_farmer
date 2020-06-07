import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;

class IconCirclet extends StatelessWidget {
  const IconCirclet({
    Key key,
    this.icon,
    this.color,
    this.label,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2.5),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(
              color: color,
              fontSize: xColors.textXs,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
