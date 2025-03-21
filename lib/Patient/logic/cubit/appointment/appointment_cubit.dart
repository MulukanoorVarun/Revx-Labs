import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Models/AppointmentDetailsModel.dart';
import '../../../../Models/AppointmentsModel.dart';
import '../../../../Models/SuccessModel.dart';
import '../../repository/appointment_repository.dart';
part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository appointmentRepository;
  AppointmentCubit(this.appointmentRepository) : super(AppointmentInitial());

  Future<void> bookAppointment(Map<String, dynamic> data) async {
    emit(AppointmentLoading());
    try {
      final appointments = await appointmentRepository.bookAppointment(data);
      if (appointments != null) {
        emit(AppointmentLoaded(appointments));
      } else {
        emit(AppointmentError("No appointments found"));
      }
    } catch (e) {
      emit(AppointmentError("Failed to fetch appointments"));
    }
  }

  Future<void> fetchAppointments() async {
    emit(AppointmentLoading());
    try {
      final appointments = await appointmentRepository.fetchAppoinments();
      if (appointments != null) {
        emit(AppointmentListLoaded(appointments));
      } else {
        emit(AppointmentError("No appointments found"));
      }
    } catch (e) {
      emit(AppointmentError("Failed to fetch appointments"));
    }
  }
}

