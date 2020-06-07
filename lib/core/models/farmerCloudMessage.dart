import 'package:urlix_farmer/core/utilities/stringOpe.dart';

class FarmerCloudMessage {
  final List<String> execCodes;
  final String company;
  final String idRecharge;
  final int mount;
  final int farmerNumber;
  FarmerCloudMessage(
      {this.execCodes,
      this.company,
      this.idRecharge,
      this.mount,
      this.farmerNumber});
  factory FarmerCloudMessage.fromCloudMessage(dynamic data) {
    List<String> codes = getExecCodes(data['execCodes'] ?? '');
    return FarmerCloudMessage(
      execCodes: codes,
      company: data['company'] ?? '',
      idRecharge: data['idRecharge'] ?? '',
      mount: int.parse(data['mount'] ?? '0'),
      farmerNumber: int.parse(data['farmerNumber'] ?? '0'),
    );
  }
}
