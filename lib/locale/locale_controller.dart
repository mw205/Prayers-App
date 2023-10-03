import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayers/model/Services/settings_services.dart';

class LocaleController extends GetxController {
  final SettingsServices settingsServices = Get.find();
  late Locale initLanguage;
  @override
  void onInit() {
    super.onInit();
    initLanguage = settingsServices.localStorage.read('lang') == 'ar'
        ? Locale('ar')
        : Locale('en');
  }

  void changeLanguage(String language_code) {
    Locale locale = Locale(language_code);
    settingsServices.localStorage.write('lang', language_code);
    Get.updateLocale(locale);
  }

  List<String> languages = ['العربية', 'English'];
  List<Option> languagesOptions = [Option(Locale('ar')), Option(Locale('en'))];
  String get appLanguage {
    if (settingsServices.localStorage.read('lang') == "ar") {
      return "العربية";
    } else {
      return "English";
    }
  }

  String get appLocale {
    if (settingsServices.localStorage.read('lang') == "ar") {
      return "ar";
    } else {
      return "en";
    }
  }
}

class Option {
  final Locale locale;
  Option(this.locale);
  String get languageName {
    if (locale.languageCode == "ar") {
      return "العربية";
    } else {
      return "English";
    }
  }
}
