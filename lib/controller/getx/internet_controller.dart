import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final RxBool _hasInternet = false.obs;
  RxBool get hasInternet => _hasInternet;

  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _hasInternet.value = false;
    } else {
      _hasInternet.value = true;
    }
    update();
  }
}
