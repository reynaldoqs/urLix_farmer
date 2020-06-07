class FarmerLog {
  final LogType type;
  final String log;
  final DateTime createdAt = DateTime.now();
  FarmerLog({this.type = LogType.action, this.log});
}

enum LogType {
  action,
  warning,
  error,
}
