import 'package:get_it/get_it.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/services/storage/storage_service.dart';
import 'package:gooloads/src/utils/connectivity_checker.dart';
import 'package:gooloads/src/utils/prefrences.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator
    ..registerLazySingleton<AuthService>(() => AuthService())
    ..registerLazySingleton<ApiService>(() => ApiService())
    ..registerLazySingleton<DataBaseService>(() => DataBaseService())
    ..registerLazySingleton<StorageService>(() => StorageService())
    ..registerLazySingleton<InternetConnectivity>(() => InternetConnectivity())
    ..registerLazySingleton<AppPrefrences>(() => AppPrefrences());
}
