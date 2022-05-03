class CalculateSalary {
  static String calculateSalary({required String time}) {
    //emp salary in week  700
    double day = 700 / 6;
    double hour = day / 8;
    double minute = hour / 60;
    List<String> timeList;
    timeList = time.split(':');
    int sDay = (int.parse(timeList[0]) * day.floor());
    int sHour = (int.parse(timeList[1]) * hour.floor());
    int sMinute = (int.parse(timeList[2]) * minute.ceil());
    return "Days : ${int.parse(timeList[0])} * ${day.floor()} = $sDay\n"
        "Hour : ${int.parse(timeList[1])} * ${hour.floor()} = $sHour\n"
        "Minute : ${int.parse(timeList[2])} * ${minute.ceil()} = $sMinute\n\n"
        "Total : ${sDay + sHour + sMinute}";
  }
}
