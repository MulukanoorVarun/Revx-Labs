part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final SuccessModel appointments;
  const AppointmentLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class AppointmentListLoaded extends AppointmentState {
  final AppointmentsModel appointmentsList;
  const AppointmentListLoaded(this.appointmentsList);

  @override
  List<Object?> get props => [appointmentsList];
}

class AppointmentDetailsLoaded extends AppointmentState {
  final AppointmentDetailsModel appointments_details;
  const AppointmentDetailsLoaded(this.appointments_details);

  @override
  List<Object?> get props => [appointments_details];
}


class AppointmentError extends AppointmentState {
  final String message;
  const AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}
