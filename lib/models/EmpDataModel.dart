class EmpDataModel {
  late String name;
  late String salary;
  late String phone;
  late String id;
  late String nId;
  late int isAttend;
  late String lastAttendance;
  late String startTime;

  EmpDataModel(this.name, this.salary, this.phone, this.id, this.nId,
      this.isAttend, this.lastAttendance, this.startTime);

  EmpDataModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    salary = json['salary'];
    phone = json['phone'];
    id = json['id'];
    nId = json['nid'];
    isAttend = json['isAttend'];
    lastAttendance = json['lastAttendance'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'salary': salary,
      'phone': phone,
      'id': id,
      'nid': nId,
      'isAttend': isAttend,
      'lastAttendance': lastAttendance,
      'startTime': startTime,
    };
  }
}
