import 'package:get/get.dart';
import 'package:prayers/controller/network_controller.dart';
import 'package:prayers/controller/notification_controller.dart';
import 'package:prayers/controller/splash_screen_controller.dart';
import 'package:prayers/controller/time_controller.dart';

import '../controller/change_notifier.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
    Get.put<ChangeNotifierController>(ChangeNotifierController());
    Get.put<TimeController>(TimeController());
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put(NotificationController());
  }
}
