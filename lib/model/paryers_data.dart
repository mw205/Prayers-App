import 'package:get/get.dart';
import 'package:prayers/controller/time_controller.dart';

class PrayersData {
  Map<String, dynamic>? timings;
  Map<String, dynamic>? hijri_date;
  String? arDay;
  String? arHijriMonth;
  String? enHijriMonth;
  String? hijriYear;
  PrayersData(
      {this.arHijriMonth,
      this.enHijriMonth,
      this.arDay,
      this.hijriYear,
      this.timings});
  factory PrayersData.fromJson(jsonData) {
    TimeController timeController = Get.find<TimeController>();
    // NotificatoinController notificatoinController =
    //     Get.find<NotificatoinController>();
    //it will be a list of maps and each one is containing information about one day
    List data = jsonData['data'];
    //every day has 3 maps (timings , date , meta)
    var day = data[int.parse(timeController.enDay.value) - 1];
    Map<String, dynamic> timingsOfDay = day['timings'];
    
    //notificatoinController.PrayersNotificationsSchedular(timingsOfDay);
    //this has 4 keys and we need only the hijri map
    Map<String, dynamic> dateMap = day['date'];
    //this has 4 keys and we need only the hijri map
    Map<String, dynamic> hijri_date = dateMap['hijri'];
    //to get the all required data
    timeController.setHijriDate(hijri_date);
    return PrayersData(timings: timingsOfDay);
  }
}
