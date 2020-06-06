import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  final String msgToken;
  final String deviceId;
  final int phoneNumber;
  final String company;
  int xDay;
  final int subscriptionId;
  final int status;
  bool isOnline;
  FarmerStatus farmerStatus;
  //List<Recharge> recharges;
  Farmer({
    this.msgToken,
    this.deviceId,
    this.phoneNumber,
    this.company,
    this.xDay,
    this.subscriptionId,
    this.status,
    this.isOnline,
    this.farmerStatus,
  });

  factory Farmer.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return Farmer(
      msgToken: data['msgToken'],
      deviceId: data['deviceId'] ?? '',
      phoneNumber: data['phoneNumber'] ?? 0,
      company: data['company'] ?? '',
      xDay: data['xDay'] ?? 0,
      subscriptionId: data['subscriptionId'],
      status: data['status'] ?? 1,
      isOnline: data['isOnline'] ?? false,
      //recharges: data['recharges'],
    );
  }

  toJson() {
    return {
      'msgToken': msgToken,
      'deviceId': deviceId,
      'phoneNumber': phoneNumber,
      'company': company,
      'xDay': xDay,
      'subscriptionId': subscriptionId,
      'status': status,
      'isOnline': isOnline,
      //'recharges': recharges
    };
  }

  bool compareTo(Farmer x) {
    if (this.msgToken == x.msgToken &&
        this.status == x.status &&
        //this.xDay == x.xDay &&
        this.deviceId == x.deviceId) {
      return true;
    }
    return false;
  }
}

enum FarmerStatus { synchronized, unSynchronized, unRegistered }

class Recharge {
  final int mount;
  final DateTime resolvedAt;
  final int target;
  Recharge({this.mount, this.resolvedAt, this.target});
  //complete this shit
}
