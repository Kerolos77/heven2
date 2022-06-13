class CalculateSalary {
  static List<int> calculateSalary(
      {required String time, required int salary}) {
    //emp salary in week  700
    double day = salary / 6;
    double hour = day / 8;
    double minute = hour / 60;
    List<String> timeList;
    timeList = time.split(':');
    int sDay = (int.parse(timeList[0]) * day.floor());
    int sHour = (int.parse(timeList[1]) * hour.floor());
    int sMinute = (int.parse(timeList[2]) * minute.ceil());
    List<int> totalTime = [];
    totalTime.add(int.parse(timeList[0]));
    totalTime.add(int.parse(timeList[1]));
    totalTime.add(int.parse(timeList[2]));
    totalTime.add(day.floor());
    totalTime.add(hour.floor());
    totalTime.add(minute.ceil());
    totalTime.add(sDay);
    totalTime.add(sHour);
    totalTime.add(sMinute);

    return totalTime;
  }
}
