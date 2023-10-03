import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayers/model/Services/settings_services.dart';

class NotificationController extends GetxController {
  late RxBool isNotificationEnabled = false.obs;
  late RxString notificationStatus = "Off".obs;
  final SettingsServices settingsServices = Get.find();

  @override
  void onInit() {
    isNotificationEnabled.value =
        settingsServices.localStorage.read('notificationEnabled') ?? false;
    updateNotificationStatus();
    super.onInit();
  }

  Future<void> checkNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (!status.isGranted) {
      isNotificationEnabled.value = false;
    } else {
      isNotificationEnabled.value = true;
    }
    updateNotificationStatus();
  }

  bool get getNotification => isNotificationEnabled.value;
  void updateNotificationStatus() {
    if (isNotificationEnabled.value == true) {
      notificationStatus.value = "On";
      settingsServices.localStorage.write('notificationEnabled', true);
    } else {
      settingsServices.localStorage.write('notificationEnabled', false);
      notificationStatus.value = "Off";
    }
  }
}
