import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  // Checks if the device has an internet connection
  static Future<bool> available() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return connectivityResult == ConnectivityResult.mobile ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == ConnectivityResult.wifi;
  }
}