import 'package:urlix_farmer/core/models/farmer.dart';
import 'package:ussd_service/ussd_service.dart';

// this func needs to have access to calls granted
Future<String> ussdOperation(int subscriptionId, String ussdCode) async {
  try {
    print("Trying $subscriptionId with $ussdCode");
    var response = await UssdService.makeRequest(subscriptionId, ussdCode);

    return response;
  } catch (e) {
    throw Exception(e);
  }
}
