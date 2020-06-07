import 'package:urlix_farmer/core/models/FarmerLog.dart';
import 'package:urlix_farmer/core/models/farmerCloudMessage.dart';
import 'package:urlix_farmer/core/providers/farmerProvider.dart';
import 'package:urlix_farmer/core/providers/loggerProvider.dart';
import 'package:urlix_farmer/core/utilities/ussdOps.dart';

Future<void> fcMessageHandler(Map<String, dynamic> message,
    FarmerProvider fProvider, LoggerProvider logger) async {
  try {
    var data /* notification*/;
    if (message.containsKey('data')) data = message['data'];
    /* if (message.containsKey('notification'))
    notification = message['notification'];*/
    if (data != null) {
      final cloudMsg = FarmerCloudMessage.fromCloudMessage(data);
      final executor = fProvider.getFarmerByNum(cloudMsg.farmerNumber);
      fProvider.toWork(executor.phoneNumber);

      if (executor == null)
        throw "${cloudMsg.farmerNumber} not found in this device";

      for (var code in cloudMsg.execCodes) {
        logger.addLog(FarmerLog(log: "${executor.phoneNumber} - USSD: $code"));
        var resp = await ussdOperation(executor.subscriptionId, code);
        logger.addLog(
            FarmerLog(log: "${executor.phoneNumber} - USSD response: $resp"));
      }
      fProvider.breakWorking();
    }
  } catch (e) {
    print(e.toString());
    logger.addLog(FarmerLog(type: LogType.error, log: e.toString()));
    fProvider.breakWorking();
  }
}
