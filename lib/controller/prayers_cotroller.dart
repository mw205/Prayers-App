import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayers/controller/location_controller.dart';
import 'package:prayers/controller/notification_controller.dart';
import 'package:prayers/controller/time_controller.dart';
import 'package:prayers/model/Services/notification_service.dart';
import 'package:prayers/model/Services/prayers_service.dart';
import 'package:prayers/model/Services/settings_services.dart';
import 'package:prayers/model/paryers_data.dart';

class PrayersController extends GetxController {
  TimeController timeController = Get.find<TimeController>();
  LocationController locationController = Get.find<LocationController>();
  NotificationController notificationController =
      Get.find<NotificationController>();
  RxInt timingsCount = 0.obs;
  PrayersData? prayersData;
  RxString nextPrayerName = "".obs;
  late DateTime nextPrayerTime;
  late Duration duration;
  RxInt remainingHours = 0.obs;
  RxInt remainingMinutes = 0.obs;
  RxInt remainingSeconds = 0.obs;
  RxMap<String, dynamic>? timingsReadable = RxMap<String, dynamic>();
  RxMap<String, dynamic>? timingsMapToSchedule = RxMap<String, dynamic>();
  RxList<String>? timingsNames = RxList<String>();
  RxList<String>? timingsValues = RxList<String>();
  RxList<String> timingsValuesToSchedule = RxList<String>();
  RxList<String> timingsNamesToSchedule = RxList<String>();
  SettingsServices settingsServices = Get.find<SettingsServices>();
  @override
  void onInit() async {
    super.onInit();
    await getPrayersData();
    extractPrayersNamesAndValues();
    getNextPrayerDetails();
  }

  void extractPrayersNamesAndValues() {
    timingsMapToSchedule!.value = prayersData!.timings!;
    timingsValuesToSchedule = extractTimeFromMap(timingsMapToSchedule);
    timingsNamesToSchedule = RxList<String>.from(timingsMapToSchedule!.keys);

    timingsReadable!.value = prayersData!.timings!;
    timingsReadable!.remove("Sunset");
    timingsReadable!.remove("Imsak");
    timingsReadable!.remove("Midnight");
    timingsReadable!.remove("Lastthird");
    timingsReadable!.remove("Firstthird");

    timingsValues = extractTimeFromMap(timingsReadable);

    if (settingsServices.localStorage.read('lang') != "ar") {
      timingsNames = RxList<String>.from(timingsReadable!.keys);
    } else {
      timingsNames!.value = [
        'الفجر',
        'الشروق',
        'الظهر',
        'العصر',
        'المغرب',
        'العشاء'
      ];
    }

    timingsCount.value = prayersData!.timings!.length;
  }

  void schedulePrayersNotification(DateTime time, String prayerName) {
    if (prayerName == "Sunrise" || prayerName == "الشروق") {
      NotificationService().showScheduledNotificatoin(
          scheduleTime: time, title: prayerName + " time", body: "duha".tr);
    } else {
      NotificationService().showScheduledNotificatoin(
          scheduleTime: time, title: "adhan".tr + " $prayerName");
    }
  }

  RxList<String> extractTimeFromMap(Map<String, dynamic>? timings) {
    return RxList<String>.from(timings!.values
        .map(
          (element) => element.replaceAll(RegExp(r'\([^)]*\)'), ""),
        )
        .toList());
  }

  Future<void> getPrayersData() async {
    prayersData = await PrayersService.getPrayers(
        timeController.georgianYear.value,
        timeController.enGeorgianMonth.value.toString(),
        locationController.longitude.value,
        locationController.latitude.value);
  }

  static void resetPrayersData() {
    Get.delete<PrayersController>();
    Get.lazyPut<PrayersController>(() => PrayersController());
  }

  void getNextPrayerDetails() {
    final currentTime = DateTime.now();
    final currentDate = DateFormat("yyyy-MM-dd").format(currentTime);

    for (int i = 0; i < timingsValues!.length; i++) {
      final parsedTime = DateFormat("yyyy-MM-dd HH:mm").parse(
        '$currentDate ${timingsValues![i]}',
      );

      if (parsedTime.isAfter(currentTime)) {
        final nextPrayerIndex = i;
        final nextPrayerTime = parsedTime;

        startCountDown(nextPrayerTime);
        nextPrayerName.value = timingsNames![nextPrayerIndex];

        if (notificationController.getNotification) {
          schedulePrayersNotification(parsedTime, nextPrayerName.value);
        }

        break;
      }
    }
    if (nextPrayerName == "") {
      nextPrayerName.value = timingsNames![0];
      String currentDate =
          DateFormat("yyyy-MM-dd").format(currentTime.add(Duration(days: 1)));
      startCountDown(DateFormat("yyyy-MM-dd HH:mm").parse(
        '${currentDate} ${timingsValues![0]}',
      ));
    }
  }

  void startCountDown(DateTime nextPrayerTime) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = nextPrayerTime.difference(now);

      if (difference.isNegative) {
        timer.cancel();
        return;
      }

      duration = Duration(
        hours: difference.inHours,
        minutes: difference.inMinutes.remainder(60),
        seconds: difference.inSeconds.remainder(60),
      );

      remainingHours.value = duration.inHours;
      remainingMinutes.value = duration.inMinutes.remainder(60);
      remainingSeconds.value = duration.inSeconds.remainder(60);

      if (duration.inSeconds == 0) {
        timer.cancel();
        getNextPrayerDetails();
      }
    });
  }
}
