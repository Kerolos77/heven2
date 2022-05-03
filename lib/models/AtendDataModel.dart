class AttendDataModel {
  late String date;
  late String startTime;
  late String endTime;
  late String empId;
  late String id;
  late String timeInDay;

  AttendDataModel(this.date, this.startTime, this.endTime, this.empId, this.id,
      this.timeInDay);

  AttendDataModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    empId = json['empId'];
    id = json['id'];
    timeInDay = json['timeInDay'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['empId'] = empId;
    data['id'] = id;
    data['timeInDay'] = timeInDay;
    return data;
  }
}
