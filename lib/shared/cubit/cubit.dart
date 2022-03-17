import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heven2/models/EmpDataModel.dart';
import 'package:heven2/models/UserDataModel.dart';
import 'package:heven2/modules/article.dart';
import 'package:heven2/modules/atendans.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'heven_states.dart';

class cubit extends Cubit<States> {
  cubit() : super(InitialState());

  static cubit get(context) => BlocProvider.of(context);

  late Database database;

  bool loginusernameflag = false;

  bool loginpassflag = false;

  bool emailflag = false;

  bool adminflag = false;

  bool passdigitalflag = false;

  bool passcapflag = false;

  bool passnumchar = false;

  bool phoneflag = false;

  bool passconfirmflag = false;

  String path = 'Heven5Data.db';

  bool fbflag = false;

  bool atendflag = true;

  IconData fbicon = Icons.edit;

  bool timeflag = false;

  bool passflag = true;

  Color atendcolor = Colors.grey;

  int cruntindex = 0;

  List<Widget> screens = [atendans(), article()];

  List<String> apptitle = ["Attendants", "Article"];

  List<String> emplloyStatus = ["monthly", "production"];

  List<Map> emplloyeeName = [];

  List<Map> productionEmplloyee = [];

  List<Map> monthlyEmployee = [];

  List<Map> atenddata = [];

  void changeindex(int index) {
    cruntindex = index;
    emit(ChangeBottonmNavBarstate());
  }

  void changeBottomSheetState({
    required bool isshow,
    required IconData icon,
  }) {
    fbflag = isshow;
    fbicon = icon;
    emit(ChangeButtomSheetState());
  }

  void create() {
    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE emplloy (id INTEGER PRIMARY KEY ,name TEXT,isatend INTEGER)')
            .then((value) {
          print('table 1 created');
        }).catchError((error) {
          print('ERROR ${error.toString()}');
        });
        database
            .execute(
                'CREATE TABLE atend (empid INTEGER ,date TEXT ,starttime TEXT , endtime TEXT )')
            .then((value) {
          print('table 2 created');
        }).catchError((error) {
          print('ERROR ${error.toString()}');
        });
      },
      onOpen: (database) {
        getdata(database);
      },
    ).then((value) {
      database = value;
      emit(CreatDataBaseState());
    });
  }

  insert({
    required String name,
    required int isatend,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO emplloy (name,isatend) VALUES("$name","$isatend")')
          .then((value) {
        print('$value insert successfully');
        emit(InsertDataBaseState());
        getdata(database);
      }).catchError((error) {
        print('Error!!!!!! ${error.toString()}');
      });
    });
  }

  insertatend({
    required int empid,
    required String date,
    required String starttime,
    required String endtime,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO atend (empid  ,date  ,starttime  , endtime ) VALUES("${empid}"  ,"${date}"  ,"${starttime}"  , "${endtime}" )')
          .then((value) {
        print('$value insert date successfully');
        emit(InsertatendDataBaseState());
        getatend(database, empid);
      }).catchError((error) {
        print('Error!!!!!! ${error.toString()}');
      });
    });
  }

  void getdata(Database database) {
    productionEmplloyee = [];
    monthlyEmployee = [];
    emplloyeeName = [];
    emit(GetDataBaseloadingState());
    database.rawQuery("SELECT * FROM emplloy").then((value) {
      value.forEach((element) {
        emplloyeeName.add(element);
        // if (element['status'] == 'production')
        //   productionEmplloyee.add(element);
        // else if (element['status'] == 'monthly')
        //   monthlyEmployee.add(element);
      });

      emit(GetDataBaseState());
    });
  }

  void getatend(Database database, int empid) {
    atenddata = [];
    print('get atend database');
    emit(GetDataBaseloadingState());
    database.rawQuery(
      "SELECT * FROM atend WHERE empid = ?",
      [empid],
    ).then((value) {
      value.forEach((element) {
        atenddata.add(element);
        print(element);
      });

      emit(GetDataBaseState());
    });
  }

  void update({
    required int isatend,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE emplloy SET isatend = ? WHERE id = ?',
      ['$isatend', id],
    ).then((value) {
      getdata(database);
      emit(UpDateDataBaseState());
    });
  }

  void updateatend({
    required String date,
    required String endtime,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE atend SET endtime = ? WHERE empid = ? AND date = ?',
      ['$endtime', id, date],
    ).then((value) {
      getatend(database, id);
      emit(UpDateDataBaseState());
    });
  }

  void delete({
    required int id,
  }) async {
    database
        .rawDelete('DELETE FROM emplloy WHERE id = ?', ['$id']).then((value) {
      getdata(database);
      emit(DeleteDataBaseState());
    });
  }

  String subTime(String startTime, String endTime) {
    DateTime startDate = DateFormat("hh:mma").parse(startTime);
    DateTime endDate = DateFormat("hh:mma").parse(endTime);
// Get the Duration using the diferrence method
    Duration diff = endDate.difference(startDate);
    String dif = '${diff.inHours}:${diff.inMinutes % 60}';

    return dif;
  }

  void changepassflag(flag) {
    passflag = flag;
    emit(ChangePassFlagState());
  }

  void changeemailflag(flag) {
    emailflag = flag;
    emit(ChangeemailFlagState());
  }

  void changeadminflag(flag) {
    adminflag = flag;
    emit(ChangeadminFlagState());
  }

  void changepassdigitalflag(flag) {
    passdigitalflag = flag;
    emit(ChangepassdigitalFlagState());
  }

  void changepasscapflag(flag) {
    passcapflag = flag;
    emit(ChangePasscapFlagState());
  }

  void changepassnumcharflag(flag) {
    passnumchar = flag;
    emit(ChangePassnumcharFlagState());
  }

  void changepassconeirmflag(flag) {
    passconfirmflag = flag;
    emit(ChangePassconfirmFlagState());
  }

  void changeloginusernameflag(flag) {
    loginusernameflag = flag;
    emit(ChangeloginusernameState());
  }

  void changeloginpassflag(flag) {
    loginpassflag = flag;
    emit(ChangeloginpassState());
  }

  void changephoneflag(flag) {
    phoneflag = flag;
    emit(ChangephoneState());
  }



///////////////fire base
  late EmpDataModel model;
  List<dynamic> modelList=[];

  ////firestore functions
  void CreateUser({
    required String name,
    required String email,
    required String adminkey,
    required String phone,
    required String UID,
  }) {
    emit(CreateUserLoadingState());
    UserDataModel userDataModel =
        UserDataModel(name, email, phone, UID, adminkey, false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .set(userDataModel.toMap())
        .then((value) {
      emit(CreateUserSucsessState());
    }).catchError((Error) {
      CreateUserErrorState(Error.toString());
    });
  }

  void CreateEmp({
    required String name,
    required String salary,
    required String phone,
    required String ID,
    required int isatend,
  }) async {
    emit(CreateEmpLoadingState());
    EmpDataModel userDataModel = EmpDataModel(name, salary, phone, ID, isatend);
    FirebaseFirestore.instance
        .collection('empolly')
        .doc(ID)
        .set(userDataModel.toMap())
        .then((value) {
      emit(CreateEmpSucsessState());
    }).catchError((Error) {
      CreateEmpErrorState(Error.toString());
    });
  }

  String CreateAtendId() {
    var uuid = Uuid();
    var v1 = uuid.v1();
    return v1;
  }

  //  void getMarker() async{
  //   const snapshot = await firebase.firestore().collection('events').get()
  //   return snapshot.docs.map(doc => doc.data());
  // }

  void GetEmp({
    required String ID,
  }) async{
    emit(GetEmpLoadingState());
    FirebaseFirestore.instance
        .collection('empolly')
        .get()
        .then((value) {

      print(value);
      // model = EmpDataModel.fromJson(value);
      print(value);
      emit(GetEmpSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetEmpErrorState(error.toString()));
    });
  }

  ///// fire Auth funcion
  void signUp({
    required String name,
    required String email,
    required String adminkey,
    required String phone,
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      CreateUser(
          email: email,
          adminkey: adminkey,
          name: name,
          phone: phone,
          UID: value.user!.uid);
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
    });
  }

  void login({
    required String email,
    required String password,
  }) {
    print(email);
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(LoginSucsessState());
      toast(msg: 'Done', backcolor: Colors.green, textcolor: Colors.black);
    }).catchError((Error) {
      emit(LoginErrorState(Error.toString()));
      print(Error.toString());
    });
  }
}
