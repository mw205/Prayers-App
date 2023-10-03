import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayers/view/widgets/dialog_utils.dart';
import 'package:prayers/model/paryers_data.dart';

class PrayersService {
  static String Url = "https://api.aladhan.com/v1/calendar/";

  static Future<PrayersData?> getPrayers(
      String year, String month, String longitude, String latitude) async {
    try {
      final response = await http.get(Uri.parse(
          "${Url}/$year/$month?latitude=$latitude&longitude=$longitude"));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        PrayersData prayersData = PrayersData.fromJson(data);
        return prayersData;
      } else {
        return null;
      }
    } catch (e) {
      DialogUtils.noNetworkDialog();
      return null;
    }
  }
}
