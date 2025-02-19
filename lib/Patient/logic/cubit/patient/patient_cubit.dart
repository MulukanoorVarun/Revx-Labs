// patient_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_state.dart';
import '../../../../Models/PatientsListModel.dart';
import '../../repository/patient_repository.dart';


class PatientCubit extends Cubit<PatientState> {
  final PatientRepository patientRepository;

  PatientCubit(this.patientRepository) : super(PatientInitialState());


  Future<void> getPatients() async {
    emit(PatientLoadingState());
    try {
      final patients = await patientRepository.getPatients();
      if (patients != null) {
        emit(PatientsListLoaded(patients));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to fetch patients.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addPatient(Map<String, dynamic> patientData) async {
    emit(PatientLoadingState());
    try {
      var response  = await patientRepository.addPatient(patientData);
      if (response != null) {
        emit(PatientLoaded(response));
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
        emit(PatientLoaded(response));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to edit patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deletePatient(id) async {
    emit(PatientLoadingState());
    try {
      var response  = await patientRepository.deletePatient(id);
      if (response != null) {
        emit(PatientLoaded(response));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to delete patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }
}
