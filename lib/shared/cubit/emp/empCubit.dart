import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/EmpDataModel.dart';
import '../../ID/CreateId.dart';
import '../../conestant/conestant.dart';
import 'empStates.dart';

class EmpCubit extends Cubit<EmpState> {
  EmpCubit() : super(InitialEmpState());

  late EmpDataModel empModel;
  List<dynamic> empModelList = [];
  bool floatButtonFlag = false;

  static EmpCubit get(context) => BlocProvider.of(context);

  // void changeTimeFlag({required bool flag}) {
  //   floatButtonFlag = flag;
  //   emit(ChangeTimeFlagState());
  // }
  void changeBottomSheetState({required IconData icon, required bool flag}) {
    // fbIcon = icon;
    floatButtonFlag = flag;
    emit(ChangeButtonSheetEmpState());
  }

  void createEmp({
    required String name,
    required String salary,
    required String phone,
    required String nId,
  }) async {
    emit(CreateLoadingEmpState());
    String id = CreateId.createId();
    EmpDataModel userDataModel =
        EmpDataModel(name, salary, phone, id, nId, 0, "0", "00:00AM");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .collection('employ')
        .doc(id)
        .set(userDataModel.toMap())
        .then((value) {
      getEmp();
      emit(CreateSuccessEmpState());
    }).catchError((error) {
      CreateErrorEmpState(error.toString());
    });
  }

  void getEmp() async {
    emit(GetLoadingEmpState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .collection('employ')
        .get()
        .then((value) {
      empModelList = [];
      for (int i = 0; i < value.docs.length; i++) {
        empModel = EmpDataModel.fromJson(value.docs[i].data());
        empModelList.add(empModel.toMap());
      }
      emit(GetSuccessEmpState());
    }).catchError((error) {
      // print(error.toString());
      emit(GetErrorEmpState(error.toString()));
    });
  }

  void updateEmp({
    required String name,
    required String salary,
    required String phone,
    required String id,
    required String nId,
    required int isAttend,
    required String lastAttendance,
    required String startTime,
  }) async {
    emit(UpdateLoadingEmpState());
    EmpDataModel empModel = EmpDataModel(
      name,
      salary,
      phone,
      id,
      nId,
      isAttend,
      lastAttendance,
      startTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .collection('employ')
        .doc(id)
        .update(empModel.toMap())
        .then((value) {
      getEmp();
      emit(UpdateSuccessEmpState());
    }).catchError((error) {
      UpdateErrorEmpState(error.toString());
    });
  }
}
