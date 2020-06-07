import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_service/models/sim_data.dart';
import 'package:sim_service/sim_service.dart';
import 'package:urlix_farmer/core/models/farmer.dart';
import 'package:urlix_farmer/core/utilities/stringOpe.dart';
import 'package:urlix_farmer/core/utilities/ussdOps.dart';
import 'package:urlix_farmer/locator.dart';

Future<List<Farmer>> readMobileFarmers() async {
  try {
    FirebaseMessaging fcm = locator<FirebaseMessaging>();
    var hasAccessToCalls = await Permission.phone.request();
    if (hasAccessToCalls.isDenied) throw 'this function needs acces to calls';
    SimData simData = await SimService.getSimData;
    if (simData == null) throw 'this mobile does not have any sim card';

    List<Farmer> mobFarmers = [];

    String mobileToken = await fcm.getToken();

    for (SimCard card in simData.cards) {
      if (card.carrierName == "No service") continue;
      String ussdResp = await ussdOperation(card.subscriptionId, '*#62#');
      int phoneNumber = int.parse(getNumFrom62(ussdResp));
      var farmer = new Farmer(
        company: card.displayName,
        deviceId: card.deviceId,
        xDay: 1,
        phoneNumber: phoneNumber,
        isOnline: false,
        msgToken: mobileToken,
        status: 1,
        subscriptionId: card.subscriptionId,
      );
      mobFarmers.add(farmer);
    }

    return mobFarmers;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}
