import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'editProfileStates.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(InitialEditProfileState());

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  static EditProfileCubit get(context) => BlocProvider.of(context);

  void changeObscurePassFlag(flag) {
    obscurePassFlag = flag;
    emit(ChangeObscurePassFlagEditProfileState());
  }

  void changeObscureConfirmFlag(flag) {
    obscureConfirmFlag = flag;
    emit(ChangeObscureConfirmFlagEditProfileState());
  }
}