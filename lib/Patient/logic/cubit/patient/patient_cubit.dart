import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_state.dart';
import '../../../../Models/PatientsListModel.dart';
import '../../repository/patient_repository.dart';


class PatientCubit extends Cubit<PatientState> {
  final PatientRepository patientRepository;

  PatientCubit(this.patientRepository) : super(PatientInitialState());


  Future<void> getPatients() async {
    emit(PatientListLoadingState());
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
    emit(PatientSavingLoadingState());
    try {
      var response  = await patientRepository.addPatient(patientData);
      if (response != null) {
        getPatients();
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
    emit(PatientSavingLoadingState());
    try {
      var response = await patientRepository.editPatient(patientData,id);
      print('id::${patientData}//${id}');
      if (response != null) {
        getPatients();
        emit(PatientLoaded(response));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to edit patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deletePatient(id) async {
    try {
      var response  = await patientRepository.deletePatient(id);
      if (response != null) {
        getPatients();
        emit(PatientLoaded(response));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to delete patient.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getPatientDetails(id) async {
    emit(PatientDetailsLoadingState());
    try {
      var response  = await patientRepository.patient_details(id);
      if (response != null) {
        emit(PatientsDetailsLoaded(response));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to fetch patientDetails.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getDefaultPatientDetails() async {
    emit(PatientDetailsLoadingState());
    try {
      var response  = await patientRepository.defaultPatientDetails();
      if (response != null) {
        emit(PatientsDetailsLoaded(response));
      } else {
        emit(PatientErrorState(errorMessage: 'Failed to fetch default patient Details.'));
      }
    } catch (e) {
      emit(PatientErrorState(errorMessage: e.toString()));
    }
  }
}
