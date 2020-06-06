import 'package:flutter/foundation.dart';
import 'package:urlix_farmer/core/models/FarmerLog.dart';

class LoggerProvider extends ChangeNotifier {
  List<FarmerLog> _farmerLogs = [];

  List<FarmerLog> getLogs() {
    return _farmerLogs;
  }

  void addLog(FarmerLog log) {
    _farmerLogs.add(log);
    notifyListeners();
  }

  void setLogs(List<FarmerLog> logs) {
    _farmerLogs = logs;
    notifyListeners();
  }
}
