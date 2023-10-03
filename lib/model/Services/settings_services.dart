import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsServices extends GetxService {
  late GetStorage localStorage;
  Future<SettingsServices> init() async {
    localStorage = GetStorage();
    return this;
  }
}
