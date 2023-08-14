import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckConnectionHandler {
  static Future<bool> checkNow() async {
    bool connectionResult = await InternetConnectionChecker().hasConnection;
    return connectionResult;
  }
}
