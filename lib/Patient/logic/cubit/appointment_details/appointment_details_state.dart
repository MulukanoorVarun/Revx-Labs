import 'package:equatable/equatable.dart';
import '../../../../Models/AppointmentDetailsModel.dart';

abstract class AppointmentDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppointmentDetailsInitial extends AppointmentDetailsState {}

class AppointmentDetailsLoading extends AppointmentDetailsState {}

class AppointmentDetailsLoaded extends AppointmentDetailsState {
  final AppointmentDetailsModel? appointmentDetails;
  AppointmentDetailsLoaded(this.appointmentDetails);

  @override
  List<Object?> get props => [appointmentDetails];
}

class AppointmentDetailsError extends AppointmentDetailsState {
  final String message;
  AppointmentDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
