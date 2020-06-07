import 'package:flutter/material.dart';
import 'package:urlix_farmer/core/models/FarmerLog.dart';
import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;

class LogTile extends StatelessWidget {
  const LogTile({Key key, this.log}) : super(key: key);
  final FarmerLog log;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${log.createdAt.day} ${log.createdAt.hour}:${log.createdAt.minute}",
            style:
                TextStyle(fontFamily: 'Inconsolata', color: xColors.textLight3),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              log.log,
              style: TextStyle(
                  fontFamily: 'Inconsolata', color: _getColor(log.type)),
            ),
          )
        ],
      ),
    );
  }

  Color _getColor(LogType type) {
    switch (type) {
      case LogType.action:
        return xColors.green2;
      case LogType.warning:
        return xColors.orange1;
      case LogType.error:
        return xColors.red1;
      default:
        return xColors.white2;
    }
  }
}
