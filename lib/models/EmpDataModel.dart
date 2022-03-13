class EmpDataModel {
  late String name;
  late String salary;
  late String phone;
  late String ID;
  late int isatend;

  EmpDataModel(this.name, this.salary, this.phone,  this.ID,this.isatend);

  EmpDataModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    salary = json['salary'];
    phone = json['phone'];
    ID = json['id'];
    isatend = json['isatend'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'salary':salary,
      'phone':phone,
      'id':ID,
      'isatend' : isatend
    };
  }

}
