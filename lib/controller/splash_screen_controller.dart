import 'package:get/get.dart';
import 'package:prayers/controller/notification_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    NotificationController()
        .checkNotificationPermission()
        .whenComplete(() async {
      Future.delayed(Duration(seconds: 1, milliseconds: 600), () {
        Get.offAllNamed("/Home");
      });
    });

    super.onReady();
  }
}
