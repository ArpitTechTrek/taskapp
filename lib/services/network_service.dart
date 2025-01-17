// ignore_for_file: unrelated_type_equality_checks
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  // Checks if the device has an internet connection
  static Future<bool> available() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
