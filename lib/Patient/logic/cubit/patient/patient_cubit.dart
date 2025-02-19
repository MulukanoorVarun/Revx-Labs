// patient_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_state.dart';
import '../../../../Models/PatientsListModel.dart';
import '../../repository/patient_repository.dart';


class PatientCubit extends Cubit<PatientState> {
  final PatientRepository patientRepository;

  PatientCubit({required this.patientRepository}) : super(PatientInitialState());

  // Fetch patients
  Future<void> getPatients() async {
    emit(PatientLoadingState());
    try {
      PatientsListModel? patients = await patientRepository.getPatients();
      if (patients != null) {
        emit(PatientSuccessState(message: 'Patients fetched successfully.'));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to fetch patients.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  // Add a new patient
  Future<void> addPatient(Map<String, dynamic> patientData) async {
    emit(PatientLoadingState());
    try {
      var response  = await patientRepository.addPatient(patientData);
      if (response != null) {
        emit(PatientSuccessState(message: 'Patient added successfully.'));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to add patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  // Edit an existing patient
  Future<void> editPatient(Map<String, dynamic> patientData,id) async {
    emit(PatientLoadingState());
    try {
      var response = await patientRepository.editPatient(patientData,id);
      if (response != null) {
        emit(PatientSuccessState(message: 'Patient edited successfully.'));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to edit patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  // Delete a patient
  Future<void> deletePatient(id) async {
    emit(PatientLoadingState());
    try {
      var response  = await patientRepository.deletePatient(id);
      if (response != null) {
        emit(PatientSuccessState(message: 'Patient deleted successfully.'));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to delete patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }
}
