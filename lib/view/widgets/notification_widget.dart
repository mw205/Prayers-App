import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayers/constants.dart';
import 'package:prayers/controller/notification_controller.dart';


class NotificationWidget extends StatelessWidget {
  NotificationWidget({super.key});
  final NotificationController notificationController =
      Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Row(
      children: [
        Icon(
          Icons.notifications,
          size: isTablet ? 26.sp : 30.sp,
          color: primColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "notification".tr,
                style: TextStyle(
                  fontSize: isTablet ? 16.sp : 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Obx(() {
                  return Text(
                    notificationController.notificationStatus.value.tr,
                    style: TextStyle(color: primColor, fontSize: 13.sp),
                  );
                }),
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Obx(
            () => Transform.scale(
              scale: isTablet ? 1.5 : 1,
              child: Switch(
                inactiveTrackColor: const Color.fromARGB(255, 215, 213, 213),
                value: notificationController.isNotificationEnabled.value,
                onChanged: (value) {
                  notificationController.isNotificationEnabled.value = value;
                },
                activeTrackColor: primColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
