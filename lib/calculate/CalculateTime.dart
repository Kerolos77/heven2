import 'package:intl/intl.dart';

class CalculateTime {
  static String subTime(String startTime, String endTime) {
    DateTime startDate = DateFormat("hh:mma").parse(startTime);
    DateTime endDate = DateFormat("hh:mma").parse(endTime);
    return '${endDate.hour - startDate.hour}:${endDate.minute - startDate.minute}';
  }

  static String totalTime({required String time, required String totalTime}) {
    List<String> timeList;
    List<String> totalTimeList;
    timeList = time.split(':');
    totalTimeList = totalTime.split(':');
    return '${int.parse(timeList[0]) + int.parse(totalTimeList[0])}:${int.parse(timeList[1]) + int.parse(totalTimeList[1])}';
  }

  static String splitTime({required String time}) {
    int hour = 15;
    int minute = 310;
    int m = minute % 60;
    int h = hour + minute ~/ 60;
    int days = h ~/ 9;
    h = h % 9;
    return '$days : $h : $m ';
  }
}
