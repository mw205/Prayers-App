import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayers/controller/prayers_cotroller.dart';
import 'package:prayers/locale/locale_controller.dart';

class DialogUtils {
  static void chooseLanguageDialog({
    required double height,
  }) {
    final LocaleController localeController = Get.find<LocaleController>();
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: 'chooseLanguage'.tr,
      titleStyle: TextStyle(fontSize: 18.sp),
      content: Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (Option language in localeController.languagesOptions)
              ListTile(
                leading: Text(
                  language.languageName,
                  style: TextStyle(fontSize: 18.sp),
                ),
                onTap: () {
                  localeController.changeLanguage(
                    language.locale.languageCode,
                  );
                  PrayersController.resetPrayersData();
                },
              )
          ],
        ),
      ),
    );
  }

  static void noNetworkDialog() {
    Get.defaultDialog(
        title: 'alert'.tr,
        backgroundColor: Colors.white,
        content: Text("internet".tr),
        barrierDismissible: false);
  }
}
