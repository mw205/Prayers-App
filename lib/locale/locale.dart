import 'package:get/get.dart';

class PrayersLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          'update': 'آخر تحديث',
          'in': 'في خلال',
          'hour': 'ساعة',
          'minute': 'دقيقة',
          'notification': 'الإشعارات',
          'On': 'مفعلة',
          'Off': 'غير مفعلة',
          'language': 'اللغة',
          'default': "يتم استخدام لغة الجهاز افتراضيًا",
          'settings': 'الإعدادات',
          'sebha': 'السبحة',
          'qibla': 'القبلة',
          'prayers': 'صلواتك',
          'chooseLanguage': 'قم باختيار اللغة',
          'adhan': ' حان الآن موعد صلاة ',
          "duha": 'اغتنم أجر صلاة الضحى',
          'internet': "تحقق من اتصالك بالإنترنت",
          'alert': 'لمواصلة استخدام التطبيق',
          'enableLocation': 'قم بتفعيل خدمة الموقع',
          'locationdenied': "لا يمكن الحصول على موقعك بسبب رفض أذونات الموقع",
          'locationdeniedpermanently':
              'تم رفض أذونات الموقع إلى الأبد، يرجى تمكينها يدويًا من الإعدادات'
        },
        "en": {
          'update': 'last updated',
          'in': 'in',
          'hour': 'Hour',
          'minute': 'Minutes',
          'notification': 'Notification',
          'On': 'On',
          'Off': 'Off',
          'language': 'Language',
          'default': "Default: local language of device",
          'settings': 'Settings',
          'sebha': 'Sebha',
          'qibla': 'Qibla',
          'prayers': 'Prayers',
          'chooseLanguage': 'Choose Language',
          'adhan': "Now it's time to pray ",
          "duha": 'اغتنم أجر صلاة الضحى',
          'internet': 'Check your Internet Connectivity',
          'alert': 'Alert',
          'enableLocation': 'Please enable location service',
          'locationdenied':
              "Can't get your location because the Location permissions are denied",
          'locationdeniedpermanently':
              'Location permissions are denied forever please enable it manually from settings'
        }
      };
}
