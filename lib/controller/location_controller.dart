import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayers/controller/prayers_cotroller.dart';
import 'package:prayers/locale/locale_controller.dart';
import 'package:prayers/view/widgets/dialog_utils.dart';

class LocationController extends GetxController {
  RxString address = "".obs;
  late Position currentPosition;
  RxString longitude = "".obs;
  RxString latitude = "".obs;
  RxBool havePermissions = false.obs;
  @override
  void onInit() async {
    super.onInit();
    getCurrentPosition();
  }

  Future<bool> handleLocationPermission() async {
    bool isServiceEnabled;
    //check if the service is enabled
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isServiceEnabled == false) {
      Get.snackbar("alert".tr, "enableLocation".tr, colorText: Colors.white);
      isServiceEnabled = await Geolocator.openLocationSettings();
      if (isServiceEnabled == false) {
        return false;
      }
    }

    if (await Permission.location.isDenied) {
      await Permission.location.request();
      if (await Permission.location.isDenied) {
        Get.snackbar("alert".tr, "locationdenied".tr,
            colorText: Colors.white, isDismissible: false);
        return false;
      }
    }
    //if it is denied forever
    if (await Permission.location.isPermanentlyDenied) {
      Get.snackbar("alert".tr, "locationdeniedpermanently".tr,
          colorText: Colors.white);
      return false;
    }
    if (await Permission.location.isGranted) {
      return true;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    havePermissions.value = await handleLocationPermission();
    if (havePermissions == false) {
      return;
    } else {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition = position;
        update();
        getCurrentAddressFromLatLng(currentPosition);
      });
    }
  }

  Future<void> getCurrentAddressFromLatLng(Position position) async {
    try {
      await placemarkFromCoordinates(position.latitude, position.longitude,
              localeIdentifier: LocaleController().appLocale)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        latitude.value = position.latitude.toString();
        longitude.value = position.longitude.toString();
        Get.put<PrayersController>(PrayersController());
        address.value = '${place.subAdministrativeArea}';
      });
    } catch (e) {
      DialogUtils.noNetworkDialog();
    }
  }

  Future<void> resetCurrentAddress() async {
    address.value = "";
    getCurrentPosition();
  }
}
