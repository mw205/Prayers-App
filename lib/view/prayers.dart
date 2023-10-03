import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayers/constants.dart';
import 'package:prayers/controller/location_controller.dart';
import 'package:prayers/controller/time_controller.dart';
import 'package:prayers/view/widgets/next_prayer_widget.dart';
import 'package:prayers/view/widgets/prayers_list.dart';

import '../controller/prayers_cotroller.dart';

class PrayersPage extends StatelessWidget {
  PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    LocationController locationController = Get.find<LocationController>();
    TimeController timeController = Get.find<TimeController>();
    return RefreshIndicator(
      color: primColor,
      onRefresh: () async {
        locationController.resetCurrentAddress();
        timeController.setLastUpdated();
        PrayersController.resetPrayersData();
      },
      child: Center(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                NextPrayerWidget(),
                SizedBox(
                  height: height * 0.03,
                ),
                PrayersList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
