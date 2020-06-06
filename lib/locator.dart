import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:urlix_farmer/core/providers/farmerProvider.dart';
import 'package:urlix_farmer/core/providers/loggerProvider.dart';
import 'package:urlix_farmer/core/services/firestoreApi.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseMessaging());
  locator.registerLazySingleton(() => FirestoreApi('farmerResolvers'));
  locator.registerLazySingleton(() => FarmerProvider());
  locator.registerLazySingleton(() => LoggerProvider());
}
