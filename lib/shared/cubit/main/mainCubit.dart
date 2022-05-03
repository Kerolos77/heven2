import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/models/UserDataModel.dart';
import 'package:heven2/modules/Employ.dart';
import 'package:sqflite/sqflite.dart';

import '../../../modules/EditProfile.dart';
import '../../../modules/ProfileCompany.dart';
import '../../../modules/article.dart';
import '../../conestant/conestant.dart';
import 'mainStates.dart';

class MainCubit extends Cubit<States> {
  MainCubit() : super(InitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  late Database database;

  bool loginUserNameFlag = false;

  bool loginPassFlag = false;

  bool emailFlag = false;

  bool adminFlag = false;

  bool passDigitalFlag = false;

  bool passCapFlag = false;

  bool passNumChar = false;

  bool phoneFlag = false;

  bool passConfirmFlag = false;

  String path = 'Heven5Data.db';

  bool attendFlag = true;

  IconData fbIcon = Icons.edit;

  bool menuFlag = false;

  bool passFlag = true;

  Color attendColor = Colors.grey;

  int currentIndex = 0;

  List<Widget> screens = [Employ(), ProfileUser(), EditProfile(), article()];

  List<String> appTitle = ["Employ", "Profile", "Edit Profile", "Article"];

  List<String> employStatus = ["monthly", "production"];

  List<Map> employName = [];

  List<Map> productionEmploy = [];

  List<Map> monthlyEmployee = [];

  List<Map> attendData = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottonmNavBarstate());
  }

  void createSqf() {
    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        // print('database created');
        database
            .execute(
                'CREATE TABLE employ (id INTEGER PRIMARY KEY ,name TEXT,isAttend INTEGER)')
            .then((value) {
          // print('table 1 created');
        }).catchError((error) {
          // print('ERROR ${error.toString()}');
        });
        database
            .execute(
                'CREATE TABLE attend (empId INTEGER ,date TEXT ,startTime TEXT , endTime TEXT )')
            .then((value) {
          // print('table 2 created');
        }).catchError((error) {
          // print('ERROR ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataSqf(database);
      },
    ).then((value) {
      database = value;
      emit(CreatDataBaseState());
    });
  }

  insertSqf({
    required String name,
    required int isAttend,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO employ (name,isAttend) VALUES("$name","$isAttend")')
          .then((value) {
        emit(InsertDataBaseState());
        getDataSqf(database);
      }).catchError((error) {});
    });
  }

  insertAttendSqf({
    required int empId,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO attend (empId  ,date  ,startTime  , endTime ) VALUES("$empId"  ,"$date"  ,"$startTime"  , "$endTime" )')
          .then((value) {
        emit(InsertatendDataBaseState());
        getAttendSqf(database, empId);
      }).catchError((error) {});
    });
  }

  void getDataSqf(Database database) {
    productionEmploy = [];
    monthlyEmployee = [];
    employName = [];
    emit(GetDataBaseloadingState());
    database.rawQuery("SELECT * FROM employ").then((value) {
      for (var element in value) {
        employName.add(element);
      }

      emit(GetDataBaseState());
    });
  }

  void getAttendSqf(Database database, int empId) {
    attendData = [];
    // print('get atend database');
    emit(GetDataBaseloadingState());
    database.rawQuery(
      "SELECT * FROM attend WHERE empId = ?",
      [empId],
    ).then((value) {
      for (var element in value) {
        attendData.add(element);
        // print(element);
      }

      emit(GetDataBaseState());
    });
  }

  void updateSqf({
    required int isAttend,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE employ SET isAttend = ? WHERE id = ?',
      ['$isAttend', id],
    ).then((value) {
      getDataSqf(database);
      emit(UpDateDataBaseState());
    });
  }

  void updateAttendSqf({
    required String date,
    required String endTime,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE attend SET endTime = ? WHERE empId = ? AND date = ?',
      [endTime, id, date],
    ).then((value) {
      getAttendSqf(database, id);
      emit(UpDateDataBaseState());
    });
  }

  void deleteSqf({
    required int id,
  }) async {
    database
        .rawDelete('DELETE FROM employ WHERE id = ?', ['$id']).then((value) {
      getDataSqf(database);
      emit(DeleteDataBaseState());
    });
  }

  void changePassFlag(flag) {
    passFlag = flag;
    emit(ChangePassFlagState());
  }

  void changeEmailFlag(flag) {
    emailFlag = flag;
    emit(ChangeemailFlagState());
  }

  void changeAdminFlag(flag) {
    adminFlag = flag;
    emit(ChangeadminFlagState());
  }

  void changePassDigitalFlag(flag) {
    passDigitalFlag = flag;
    emit(ChangepassdigitalFlagState());
  }

  void changePassCapFlag(flag) {
    passCapFlag = flag;
    emit(ChangePasscapFlagState());
  }

  void changePassNumCharFlag(flag) {
    passNumChar = flag;
    emit(ChangePassnumcharFlagState());
  }

  void changePassConfirmFlag(flag) {
    passConfirmFlag = flag;
    emit(ChangePassconfirmFlagState());
  }

  void changeLoginUserNameFlag(flag) {
    loginUserNameFlag = flag;
    emit(ChangeloginusernameState());
  }

  void changeLoginPassFlag(flag) {
    loginPassFlag = flag;
    emit(ChangeloginpassState());
  }

  void changePhoneFlag(flag) {
    phoneFlag = flag;
    emit(ChangephoneState());
  }

///////////////fire base

  void createUser({
    required String name,
    required String email,
    required String adminKey,
    required String phone,
    required String uId,
  }) async {
    emit(CreateUserLoadingState());
    UserDataModel userDataModel =
        UserDataModel(name, email, phone, uId, adminKey, false);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userDataModel.toMap())
        .then((value) {
      emit(CreateUserSucsessState());
    }).catchError((error) {
      CreateUserErrorState(error.toString());
    });
  }

  ///// fire Auth function
  void signUp({
    required String name,
    required String email,
    required String adminKey,
    required String phone,
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          email: email,
          adminKey: adminKey,
          name: name,
          phone: phone,
          uId: value.user!.uid);
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
    });
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      constUid = value.user!.uid;
      emit(LoginSucsessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    emit(LogOutSucsessState());
  }
}
