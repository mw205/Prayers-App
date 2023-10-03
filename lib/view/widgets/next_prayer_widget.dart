import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayers/controller/prayers_cotroller.dart';
import 'package:prayers/view/widgets/skelton.dart';

class NextPrayerWidget extends StatelessWidget {
  final PrayersController prayersController = Get.find<PrayersController>();

  NextPrayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.12,
      width: width * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/6348833.jpg"),
            fit: BoxFit.cover,
            opacity: 0.05),
        borderRadius: BorderRadius.circular(24),
        color: Color.fromARGB(255, 24, 64, 134),
      ),
      child: Center(
        child: Obx(
          () {
            if (prayersController.nextPrayerName == "") {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Skelton(
                      color: Colors.white,
                      height: (height * 0.12) / 6,
                      width: (width * 0.8) / 2),
                  SizedBox(
                    height: (height * 0.12) / 4,
                  ),
                  Skelton(
                      color: Colors.white,
                      height: (height * 0.12) / 6,
                      width: (width * 0.8) / 1.5),
                ],
              );
            }
            if (prayersController.remainingHours == 0 &&
                prayersController.remainingMinutes == 0) {
              return Center(
                child: Text(
                  "${prayersController.nextPrayerName} ".tr,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ).animate().fade();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //next salah
                  Text(
                    "${prayersController.nextPrayerName} " + "in".tr,
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: height > 900 ? height * 0.01 : height * 0.02,
                  ),
                  //time to next salah
                  Text(
                    "${prayersController.remainingHours} " +
                        "hour".tr +
                        " ${prayersController.remainingMinutes} " +
                        "minute".tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ).animate().fade();
            }
          },
        ),
      ),
    );
  }
}
