abstract class States {}

class InitialState extends States {}

class ChangeBottonmNavBarstate extends States {}

class CreatDataBaseState extends States {}

class InsertDataBaseState extends States {}

class GetDataBaseState extends States {}

class UpDateDataBaseState extends States {}

class DeleteDataBaseState extends States {}

class GetDataBaseloadingState extends States {}

class ChangeButtomSheetState extends States {}

class ChangeButtonState extends States {}

class ChangeColorAtendState extends States {}

class ChangeVisbleAtendState extends States {}

class InsertatendDataBaseState extends States {}

class ChangePassFlagState extends States {}

class ChangeemailFlagState extends States {}

class ChangeadminFlagState extends States {}

class ChangepassdigitalFlagState extends States {}

class ChangePasscapFlagState extends States {}

class ChangePassnumcharFlagState extends States {}

class ChangePassconfirmFlagState extends States {}

class ChangeloginusernameState extends States {}

class ChangeloginpassState extends States {}

class ChangephoneState extends States {}

class SignUpSucsessState extends States {}

class SignUpErrorState extends States {
  var error;
  SignUpErrorState(String Error) {
    error = Error;
  }
}

class SignUpLoadingState extends States {}

class LoginSucsessState extends States {}

class LoginLoadingState extends States {}

class LoginErrorState extends States {
  var error;
  LoginErrorState(String Error) {
    error = Error;
  }
}

class CreateUserSucsessState extends States {}

class CreateUserLoadingState extends States {}

class CreateUserErrorState extends States {
  var error;
  CreateUserErrorState(String Error) {
    error = Error;
  }
}
