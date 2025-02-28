// Cubit
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/appointment_repository.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  final AppointmentRepository appointmentRepository;

  AppointmentDetailsCubit(this.appointmentRepository) : super(AppointmentDetailsInitial());

  Future<void> fetchAppointmentDetails(String id) async {
    emit(AppointmentDetailsLoading());
    try {
      final details = await appointmentRepository.AppointmentDetails(id);
      emit(AppointmentDetailsLoaded(details));
    } catch (e) {
      emit(AppointmentDetailsError("Failed to fetch appointment details"));
    }
  }
}