class AtendDataModel {
  late String date;
  late String starttime;
  late String endtime;
  late String empid;
  late String id;
  late String timeInDay;

  AtendDataModel(this.date, this.starttime, this.endtime, this.empid, this.id,
      this.timeInDay);

  AtendDataModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    empid = json['empid'];
    id = json['id'];
    timeInDay = json['timeInDay'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['empid'] = this.empid;
    data['id'] = this.id;
    data['timeInDay'] = this.timeInDay;
    return data;
  }
}
