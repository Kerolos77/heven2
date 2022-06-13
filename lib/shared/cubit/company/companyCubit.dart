import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/UserDataModel.dart';
import '../../conestant/conestant.dart';
import 'companyStates.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(InitialUserState());

  bool loginUserNameFlag = false;

  bool loginPassFlag = false;

  bool emailFlag = false;

  bool passNumChar = false;

  bool phoneFlag = false;

  bool passConfirmFlag = false;

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  bool nameFlag = false;

  static CompanyCubit get(context) => BlocProvider.of(context);

  void createUser({
    required String name,
    required String email,
    required String adminKey,
    required String phone,
    required String uId,
  }) async {
    emit(CreateLoadingUserState());
    UserDataModel userDataModel =
        UserDataModel(name, email, phone, uId, adminKey, false);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userDataModel.toMap())
        .then((value) {
      emit(CreateSuccessUserState());
    }).catchError((error) {
      CreateErrorUserState(error.toString());
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
    emit(SignUpLoadingUserState());
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
      emit(SignUpErrorUserState(error.toString()));
    });
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingUserState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      constUid = value.user!.uid;
      emit(LoginSuccessUserState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorUserState(error.toString()));
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    emit(LogOutSuccessUserState());
  }

  void changeObscurePassFlag(flag) {
    obscurePassFlag = flag;
    emit(ChangeObscurePassFlagUserState());
  }

  void changeObscureConfirmFlag(flag) {
    obscureConfirmFlag = flag;
    emit(ChangeObscureConfirmFlagUserState());
  }

  void changeEmailFlag(flag) {
    emailFlag = flag;
    emit(ChangeEmailFlagUserState());
  }

  void changePassNumCharFlag(flag) {
    passNumChar = flag;
    emit(ChangePassNumCharFlagUserState());
  }

  void changePassConfirmFlag(flag) {
    passConfirmFlag = flag;
    emit(ChangePassConfirmFlagUserState());
  }

  void changeLoginUserNameFlag(flag) {
    loginUserNameFlag = flag;
    emit(ChangeLoginUserNameUserState());
  }

  void changeLoginPassFlag(flag) {
    loginPassFlag = flag;
    emit(ChangeLoginPassUserState());
  }

  void changePhoneFlag(flag) {
    phoneFlag = flag;
    emit(ChangePhoneUserState());
  }

  void changeNameFlag(flag) {
    nameFlag = flag;
    emit(ChangeNameUserState());
  }
}
