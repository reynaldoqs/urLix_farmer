import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:urlix_farmer/core/models/farmer.dart';
import 'package:urlix_farmer/ui/utilities/colors.dart' as xColors;

class FarmerConfig extends StatefulWidget {
  FarmerConfig({Key key, this.farmer, this.onUpdateFarmer, this.onRegFarmer})
      : super(key: key);

  Farmer farmer;
  OnFarmerVoidCall onUpdateFarmer;
  OnFarmerVoidCall onRegFarmer;

  @override
  _FarmerConfigState createState() => _FarmerConfigState();
}

typedef OnFarmerVoidCall = Function(Farmer farmer);

class _FarmerConfigState extends State<FarmerConfig> {
  bool isOpen = false;
  Farmer aCopy;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        int currentVal;
        return AlertDialog(
          backgroundColor: xColors.black2,
          title: Text('Double charge day'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Select your doble charge day, be careful!',
                    style: TextStyle(
                        color: xColors.textLight3, fontSize: xColors.textXs)),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    currentVal = int.parse(value);
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  aCopy.xDay = currentVal;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aCopy = widget.farmer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: xColors.black2,
        child: Column(
          children: <Widget>[
            ExpansionTile(
              backgroundColor: xColors.black2,
              initiallyExpanded: false,
              title: Text(
                aCopy.phoneNumber.toString(),
              ),
              subtitle: Text(
                aCopy.company,
                style: TextStyle(
                  color: xColors.textLight3,
                  fontSize: xColors.textXs,
                ),
              ),
              trailing: Icon(isOpen
                  ? EvaIcons.chevronUpOutline
                  : EvaIcons.chevronDownOutline),
              leading: Text("SIM"),
              children: <Widget>[
                ListTile(
                  title: Text('Status'),
                  subtitle: Text(aCopy.isOnline ? 'online' : 'offline'),
                  trailing: Switch(
                      value: aCopy.isOnline,
                      onChanged: (value) {
                        setState(() {
                          aCopy.isOnline = value;
                        });
                      }),
                ),
                ListTile(
                  title: Text('Double recharge day'),
                  trailing: InkWell(
                    onTap: () {
                      _showMyDialog();
                    },
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Text(aCopy.xDay.toString()),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Device ID'),
                  trailing: Text(
                    aCopy.deviceId,
                    style: TextStyle(color: xColors.textLight2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    widget.farmer.farmerStatus == FarmerStatus.unRegistered
                        ? RaisedButton(
                            color: xColors.white2,
                            child: Text(
                              "REG FARMER",
                              style: TextStyle(color: xColors.textDark1),
                            ),
                            onPressed: () {
                              widget.onRegFarmer(aCopy);
                            },
                          )
                        : RaisedButton(
                            color: xColors.white2,
                            child: Text(
                              "SYNC FARMER",
                              style: TextStyle(color: xColors.textDark1),
                            ),
                            onPressed: () {
                              widget.onUpdateFarmer(aCopy);
                            },
                          ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
              onExpansionChanged: (value) {
                print(value);
                setState(() {
                  isOpen = value;
                });
              },
            ),
          ],
        ));
  }
}
