import 'package:gagu_schedule/domain/model/Rasp.dart';
import 'package:gagu_schedule/data/api/model/RaspApi.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RaspMapper {
  static Rasp fromApi(RaspApi rasp) {
    return Rasp(
      weekday: rasp.weekday,
      discipline: rasp.discipline,
      group: rasp.group,
      teacher: rasp.teacher,
      classroom: rasp.classroom,
      start_time: rasp.start_time,
      end_time: rasp.end_time,
      color: getColor(rasp.discipline.substring(0, 2)),
      date: getDate(rasp.date),
    );
  }

  static getDate(String date) {
    return DateFormat.MMMMd('ru').format(DateTime.parse(date));
  }

  static int getColor(String type) {
    switch (type) {
      case "пр":
        return 0xb4e49401;
      case "ла":
        return 0xb4801b80;
      case "ко":
        return 0xb42196f3;
      case "эк":
        return 0xb42196f3;
    }
    return 0xb4016f01;
  }
}
