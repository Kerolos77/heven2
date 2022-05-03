abstract class AttendState {}

class InitialAttendState extends AttendState {}

class CreateSuccessAttendState extends AttendState {}

class CreateLoadingAttendState extends AttendState {}

class CreateErrorAttendState extends AttendState {
  late String error;

  CreateErrorAttendState(this.error);
}

class GetSuccessAttendState extends AttendState {}

class GetLoadingAttendState extends AttendState {}

class GetErrorAttendState extends AttendState {
  late String error;

  GetErrorAttendState(this.error);
}

class UpdateSuccessAttendState extends AttendState {}

class UpdateLoadingAttendState extends AttendState {}

class UpdateErrorAttendState extends AttendState {
  late String error;

  UpdateErrorAttendState(this.error);
}
