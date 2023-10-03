import 'package:get/get.dart';

class ChangeNotifierController extends GetxController {
  // RxBool isSelected = false.obs;
  RxInt _currentIndex = 1.obs;
  set selctItem(int index) {
    _currentIndex.value = index;
  }

  int get currentIndex => _currentIndex.value;
}
