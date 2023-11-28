// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class TimesNotification {
  final int id;
  final String name;

  TimesNotification(
    this.id,
    this.name,
  );

  static List<TimesNotification> listTimesNotification() {
    return <TimesNotification>[
      TimesNotification(1, 'cEachHour'),
      TimesNotification(6, 'cEachSixHours'),
      TimesNotification(12, 'cTwiceDaily'),
      TimesNotification(24, 'cOnceADay'),
      TimesNotification(99, 'cDontNotify'),
    ];
  }

  static getListTimes() {
    List<TimesNotification> listTimes = listTimesNotification();

    List<dynamic> res = listTimes
        .map((lang) => {
              'id': lang.id,
              'name': lang.name.tr,
            })
        .toList();
    return res;
  }
}
