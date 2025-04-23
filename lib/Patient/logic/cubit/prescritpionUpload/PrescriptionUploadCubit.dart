

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/prescritpionUpload/PrescriptionUploadStates.dart';
import 'package:revxpharma/Patient/logic/repository/PrescriptionUploadRepository.dart';

class UploadPrescriptionCubit extends Cubit<UploadPrescriptionState> {
  PrescriptionUploadRepository prescriptionUploadRepository;

  UploadPrescriptionCubit(this.prescriptionUploadRepository) : super(UploadPrescriptionStateIntially());

  Future<void> uploadPrescription(Map<String, dynamic> data) async {
    emit(UploadPrescriptionStateLoading());
    try {
      final response = await prescriptionUploadRepository.postUploadPrescription(data);
      if (response != null) {
        if (response.settings?.success == 1) {
          emit(UploadPrescriptionStateSuccessState(response,
              response.settings?.message ?? "Login successful!"));
        } else {
          emit(UploadPrescriptionStateError("Invalid credentials. Please try again."));
        }
      } else {
        emit(UploadPrescriptionStateError("Unexpected error occurred. Please try again later."));
      }
    } catch (e) {
      emit(UploadPrescriptionStateError(
          "An error occurred while logging in. Please check your network connection and try again."));
    }
  }
}