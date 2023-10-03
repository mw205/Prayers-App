import 'package:get/get.dart';

class SebhaController extends GetxController {
  RxInt count = 0.obs;
  RxDouble progress = (0.0).obs;
  List<String> zekr = ["سُبحَان الله", "الله أكبر", "استغفر الله"];
  RxInt zekrIndex = 0.obs;
  void incrementCounter() {
    count++;
    progress.value = count.value / 33.00;
    if (progress.value == 1) {
      count.value = 0;
      progress.value = 0;
      ++zekrIndex;
      if (zekrIndex.value == zekr.length) {
        zekrIndex.value = 0;
      }
    }
  }
}
