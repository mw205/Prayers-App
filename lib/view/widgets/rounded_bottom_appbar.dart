import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayers/constants.dart';
import 'package:prayers/controller/location_controller.dart';
import 'package:prayers/controller/prayers_cotroller.dart';
import 'package:prayers/controller/time_controller.dart';
import 'package:prayers/locale/locale_controller.dart';
import 'package:prayers/view/widgets/skelton.dart';

class RoundedBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double appBarHeight = 1.h > 1.5 ? 90.h : 80.h;
  final TimeController timeController = Get.find<TimeController>();
  final LocationController locationController = Get.find<LocationController>();
  RoundedBottomAppBar({super.key}); // Adjust this value as needed

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/6348833.jpg"),
                fit: BoxFit.cover,
                opacity: 0.05,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              color: primColor // Customize the background color
              ),
          child: AppBar(
            backgroundColor: Colors
                .transparent, // Set the app bar background color to transparent
            title: Obx(
              () => Text(
                timeController.time.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Obx(
                      () {
                        if (locationController.address.value.isEmpty) {
                          // Show circular progress indicator while the address is empty
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Skelton(
                                color: Colors.white,
                                height: (height * 0.12) / 6,
                                width: (width * 0.5),
                              ),
                              SizedBox(height: (height * 0.12) / 8),
                              Skelton(
                                color: Colors.white,
                                height: (height * 0.12) / 6,
                                width: (width * 0.45),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              )
                            ],
                          );
                        } else {
                          // Show the address
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                locationController.address.value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height < 900 ? 20.sp : 16.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      locationController.resetCurrentAddress();
                                      timeController.setLastUpdated();
                                      PrayersController.resetPrayersData();
                                    },
                                    child: Icon(
                                      Icons.replay_outlined,
                                      size: 15.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        LocaleController().appLocale == "ar"
                                            ? EdgeInsets.only(
                                                right: 5.0,
                                              )
                                            : EdgeInsets.only(left: 5),
                                    child: Text(
                                      "update".tr +
                                          " : ${timeController.lastUpdate}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height < 900 ? 10.sp : 8.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              height > 900
                                  ? SizedBox(
                                      height: height * 0.05,
                                    )
                                  : SizedBox()
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () {
                  if (timeController.hijriDateReadable.value == "") {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Skelton(
                        color: Colors.white,
                        height: (height * 0.12) / 6,
                        width: (width * 0.8) / 1.5,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        timeController.hijriDateReadable.value,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15.sp,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
