import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlix_farmer/core/models/FarmerLog.dart';
import 'package:urlix_farmer/core/providers/loggerProvider.dart';

import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;
import 'package:urlix_farmer/ui/widgets/logTile.dart';

class Logger extends StatelessWidget {
  const Logger({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var farmerProvider = Provider.of<LoggerProvider>(context);
    ScrollController _scrollController = new ScrollController();
    return Scaffold(
      backgroundColor: xColors.black1,
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: farmerProvider.getLogs().length,
          itemBuilder: (BuildContext context, int index) {
            return LogTile(
              log: farmerProvider.getLogs()[index],
            );
          },
        ),
      ),
    );
  }
}
