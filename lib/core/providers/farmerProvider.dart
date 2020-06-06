import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:urlix_farmer/core/models/FarmerLog.dart';
import 'package:urlix_farmer/core/models/farmer.dart';
import 'package:urlix_farmer/core/providers/loggerProvider.dart';
import 'package:urlix_farmer/core/services/firestoreApi.dart';
import 'package:urlix_farmer/core/utilities/farmerOps.dart';
import 'package:urlix_farmer/locator.dart';

class FarmerProvider extends ChangeNotifier {
  FirestoreApi _api = locator<FirestoreApi>();
  LoggerProvider _logger = locator<LoggerProvider>();

  List<Farmer> farmers;
  Farmer sim1;
  Farmer sim2;

  Future<void> setupFarmers() async {
    try {
      // _logger
      // .addLog(FarmerLog(type: LogType.action, log: "init setupFarmers..."));
      var mFarmers = await readMobileFarmers();

      for (var i = 0; i < mFarmers.length; i++) {
        print(mFarmers[i].phoneNumber.toString());
        var firebaseFarmer =
            await getFarmerById(mFarmers[i].phoneNumber.toString());

        if (firebaseFarmer == null) {
          mFarmers[i].farmerStatus = FarmerStatus.unRegistered;
          continue;
        }
        if (mFarmers[i].compareTo(firebaseFarmer)) {
          mFarmers[i] = firebaseFarmer;
          mFarmers[i].farmerStatus = FarmerStatus.synchronized;
          // put online
        } else {
          mFarmers[i].farmerStatus = FarmerStatus.unSynchronized;
        }
      }

      String status1 =
          "${mFarmers[0].phoneNumber} - ${mFarmers[0].farmerStatus}";
      String status2 =
          "${mFarmers[1].phoneNumber} - ${mFarmers[1].farmerStatus}";
      print(status1);
      print(status2);
      _logger.addLog(new FarmerLog(type: LogType.action, log: status1));
      _logger.addLog(new FarmerLog(type: LogType.action, log: status2));

      if (mFarmers[0] != null) setSim1Farmer(mFarmers[0]);
      if (mFarmers[1] != null) setSim2Farmer(mFarmers[1]);
    } catch (e) {
      _logger.addLog(new FarmerLog(type: LogType.error, log: e.toString()));
      print("farmerProvider.setupFarmers - error: ${e.toString()}");
    }
  }

  Future<List<Farmer>> fetchFarmers() async {
    var result = await _api.getDataCollection();
    farmers = result.documents.map((doc) => Farmer.fromFirestore(doc)).toList();
    return farmers;
  }

  Stream<QuerySnapshot> fetchFarmersAsStream() {
    return _api.streamDataCollection();
  }

  Future<Farmer> getFarmerById(String id) async {
    try {
      var doc = await _api.getDocumentById(id);

      return Farmer.fromFirestore(doc);
    } catch (_) {
      return null;
    }
  }

  Future removeFarmer(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateFarmer(Farmer data, String id) async {
    //TODO: update locally
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addFarmer(Farmer data) async {
    if (sim1.phoneNumber == data.phoneNumber) setSim1Farmer(data);
    if (sim2.phoneNumber == data.phoneNumber) setSim2Farmer(data);
    await _api.updateOrCreateDoc(
      data.phoneNumber.toString(),
      data.toJson(),
    );
    return;
  }

  //local updates

  void setSim1Farmer(Farmer farmer) {
    sim1 = farmer;
    notifyListeners();
  }

  void setSim2Farmer(Farmer farmer) {
    sim2 = farmer;
    notifyListeners();
  }
}
