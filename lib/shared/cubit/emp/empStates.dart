abstract class EmpState {}

class InitialEmpState extends EmpState {}

class CreateSuccessEmpState extends EmpState {}

class CreateLoadingEmpState extends EmpState {}

class CreateErrorEmpState extends EmpState {
  late String error;

  CreateErrorEmpState(this.error);
}

class GetSuccessEmpState extends EmpState {}

class GetLoadingEmpState extends EmpState {}

class GetErrorEmpState extends EmpState {
  late String error;

  GetErrorEmpState(this.error);
}

class UpdateSuccessEmpState extends EmpState {}

class UpdateLoadingEmpState extends EmpState {}

class UpdateErrorEmpState extends EmpState {
  late String error;

  UpdateErrorEmpState(this.error);
}

class ChangeButtonSheetEmpState extends EmpState {}
