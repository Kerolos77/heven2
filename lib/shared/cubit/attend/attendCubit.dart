import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/calculate/CalculateTime.dart';
import 'package:intl/intl.dart';

import '../../../models/AtendDataModel.dart';
import '../../conestant/conestant.dart';
import 'attendStates.dart';

class AttendCubit extends Cubit<AttendState> {
  AttendCubit() : super(InitialAttendState());
  late AttendDataModel attendModel;
  List<dynamic> attendModelList = [];

  String publicDate = DateFormat('yyyy-MM').format(DateTime.now());

  static AttendCubit get(context) => BlocProvider.of(context);

  void createAttend({
    required String date,
    required String startTime,
    required String endTime,
    required String empId,
    required String id,
  }) async {
    emit(CreateLoadingAttendState());

    AttendDataModel userDataModel = AttendDataModel(date, startTime, endTime,
        empId, id, CalculateTime.subTime(startTime, endTime));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .collection('employ')
        .doc(empId)
        .collection('attend $publicDate')
        .doc(id)
        .set(userDataModel.toMap())
        .then((value) {
      getAttend(
        empId: empId,
        date: date,
      );
      emit(CreateSuccessAttendState());
    }).catchError((error) {
      CreateErrorAttendState(error.toString());
    });
  }

  void getAttend({required String empId, required String date}) async {
    emit(GetLoadingAttendState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .collection('employ')
        .doc(empId)
        .collection('attend $publicDate')
        .get()
        .then((value) {
      attendModelList = [];
      for (int i = 0; i < value.docs.length; i++) {
        attendModel = AttendDataModel.fromJson(value.docs[i].data());
        attendModelList.add(attendModel.toMap());
      }
      emit(GetSuccessAttendState());
    }).catchError((error) {
      emit(GetErrorAttendState(error.toString()));
    });
  }

  void updateAttend({
    required String endTime,
    required String startTime,
    required String empId,
    required String id,
  }) async {
    emit(UpdateLoadingAttendState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .collection('employ')
        .doc(empId)
        .collection('attend $publicDate')
        .doc(id)
        .update({
      "endTime": endTime,
      "timeInDay": CalculateTime.subTime(startTime, endTime)
    }).then((value) {
      getAttend(
          empId: empId, date: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      emit(UpdateSuccessAttendState());
    }).catchError((error) {
      UpdateErrorAttendState(error.toString());
    });
  }

  void ChangeDate({required String date}) async {
    publicDate = date;
    emit(ChangeDateSuccessAttendState());
  }
}
