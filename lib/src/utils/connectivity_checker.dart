import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  final Connectivity connectivity = Connectivity();

  Future<ConnectivityResult> checkInternetConnectivity() async {
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    return connectivityResult;
  }

  // Stream<ConnectivityResult> getConnectivityStream() {
  //   return connectivity.onConnectivityChanged;
  // }
}
