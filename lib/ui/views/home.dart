import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:urlix_farmer/ui/widgets/dateInformation.dart';
import 'package:urlix_farmer/core/providers/farmerProvider.dart';
import 'package:urlix_farmer/core/providers/loggerProvider.dart';
import 'package:urlix_farmer/core/utilities/messageHandler.dart';
import 'package:urlix_farmer/locator.dart';
import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;
import 'package:urlix_farmer/ui/widgets/circletIcon.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var loggerProvider = locator<LoggerProvider>();
  var farmerProvider = locator<FarmerProvider>();
  @override
  void initState() {
    super.initState();

    var _fcm = locator<FirebaseMessaging>();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        await fcMessageHandler(message, farmerProvider, loggerProvider);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        print("WE ARE GOING TO EXEC RESUME");
      },
      // called when the app has been closed completely and it's opened
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        print("WE ARE GOING TO EXEC LAOUNCH");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FarmerProvider>(context);

    return Scaffold(
      backgroundColor: xColors.black1.withOpacity(0.7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: xColors.black1.withOpacity(0),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              EvaIcons.activity,
              color: xColors.green1,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/logs');
            },
          ),
        ],
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DateInformation(),
          SpinKitRipple(
            borderWidth: 4,
            color: xColors.green1,
            size: 60,
          ),
          fp.sim1 != null
              ? IconCirclet(
                  color: fp.sim1.isWorking ? xColors.green1 : xColors.textDark3,
                  label: farmerProvider.sim1.company,
                  icon: Icons.sim_card,
                )
              : IconCirclet(
                  color: xColors.red1,
                  label: "SIM1",
                  icon: Icons.sim_card_alert,
                ),
          fp.sim2 != null
              ? IconCirclet(
                  color: fp.sim2.isWorking ? xColors.green1 : xColors.textDark3,
                  label: farmerProvider.sim2.company,
                  icon: Icons.sim_card,
                )
              : IconCirclet(
                  color: xColors.red1,
                  label: "SIM2",
                  icon: Icons.sim_card_alert,
                ),
          IconCirclet(
            color: xColors.textDark3,
            icon: EvaIcons.settingsOutline,
            label: "Config",
            onTap: () {
              Navigator.pushNamed(context, '/config');
            },
          ),
        ],
      )),
    );
  }
}
