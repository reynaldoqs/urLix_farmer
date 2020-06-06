import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlix_farmer/core/models/farmer.dart';
import 'package:urlix_farmer/core/providers/farmerProvider.dart';
import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;
import 'package:urlix_farmer/ui/widgets/farmerConfig.dart';

class Config extends StatefulWidget {
  const Config({Key key}) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    final farmerProvider = Provider.of<FarmerProvider>(context);
    final _formKey = GlobalKey<FormState>();
    void _updateFarmer(Farmer farmer) {
      //TODO: change update for just update some fields
      //DATA: split functions "create""update"
      farmerProvider.addFarmer(farmer);
    }

    return Scaffold(
        backgroundColor: xColors.black1,
        appBar: AppBar(
          backgroundColor: xColors.black2,
          title: Text(
            'Configuration',
            style: TextStyle(
              color: xColors.white2,
              fontSize: xColors.textMd,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              farmerProvider.sim1 != null
                  ? FarmerConfig(
                      farmer: farmerProvider.sim1,
                      onUpdateFarmer: (value) {
                        _updateFarmer(value);
                      },
                      onRegFarmer: (value) {
                        _updateFarmer(value);
                      },
                    )
                  : null,
              farmerProvider.sim2 != null
                  ? FarmerConfig(
                      farmer: farmerProvider.sim2,
                      onUpdateFarmer: (value) {
                        _updateFarmer(value);
                      },
                      onRegFarmer: (value) {
                        _updateFarmer(value);
                      },
                    )
                  : null,
            ]),
          ),
        ));
  }
}
