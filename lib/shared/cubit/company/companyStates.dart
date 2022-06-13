abstract class CompanyState {}

class InitialUserState extends CompanyState {}

class SignUpSuccessUserState extends CompanyState {}

class SignUpErrorUserState extends CompanyState {
  late String error;

  SignUpErrorUserState(this.error);
}

class SignUpLoadingUserState extends CompanyState {}

class LoginSuccessUserState extends CompanyState {
  late String uId;

  LoginSuccessUserState(this.uId);
}

class LoginLoadingUserState extends CompanyState {}

class LoginErrorUserState extends CompanyState {
  late String error;

  LoginErrorUserState(this.error);
}

class CreateSuccessUserState extends CompanyState {}

class CreateLoadingUserState extends CompanyState {}

class CreateErrorUserState extends CompanyState {
  late String error;

  CreateErrorUserState(this.error);
}

class LogOutSuccessUserState extends CompanyState {}

class ChangeLoginUserNameUserState extends CompanyState {}

class ChangeLoginPassUserState extends CompanyState {}

class ChangePhoneUserState extends CompanyState {}

class ChangePassConfirmFlagUserState extends CompanyState {}

class ChangePassNumCharFlagUserState extends CompanyState {}

class ChangeEmailFlagUserState extends CompanyState {}

class ChangeObscurePassFlagUserState extends CompanyState {}

class ChangeObscureConfirmFlagUserState extends CompanyState {}

class ChangeNameUserState extends CompanyState {}
