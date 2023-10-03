import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';

class QiblaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<QiblahDirection?> qiblaDirection = Rx<QiblahDirection?>(null);
  late Animation<double> animation;
  late AnimationController animationController;
  double begin = 0.0;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController);
    FlutterQiblah.qiblahStream.listen((QiblahDirection direction) {
      qiblaDirection.value = direction;
      animation = Tween(
        begin: animation.value,
        end: (direction.qiblah) * (pi / 180) * -1,
      ).animate(animationController);
      animationController.forward(from: 0);
    });
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
