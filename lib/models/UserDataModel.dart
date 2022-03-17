class UserDataModel {
  late String name;
  late String email;
  late String phone;
  late String UID;
  late String adminkey;
  late bool isvrify;


  UserDataModel(this.name, this.email, this.phone, this.UID, this.adminkey,this.isvrify);

  UserDataModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    UID = json['uid'];
    adminkey = json['adminkey'];
    isvrify = json['isvrify'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'adminkey':adminkey,
      'uid':UID,
      'isvrify':isvrify,
    };
  }

}
