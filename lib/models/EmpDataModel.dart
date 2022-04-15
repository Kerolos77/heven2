class EmpDataModel {
  late String name;
  late String salary;
  late String phone;
  late String ID;
  late String NID;
  late int isatend;
  late String lastAttendance;
  late String startTime;

  EmpDataModel(this.name, this.salary, this.phone, this.ID, this.NID,
      this.isatend, this.lastAttendance, this.startTime);

  EmpDataModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    salary = json['salary'];
    phone = json['phone'];
    ID = json['id'];
    NID = json['nid'];
    isatend = json['isatend'];
    lastAttendance = json['lastAttendance'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'salary': salary,
      'phone': phone,
      'id': ID,
      'nid': NID,
      'isatend': isatend,
      'lastAttendance': lastAttendance,
      'startTime': startTime,
    };
  }
}
