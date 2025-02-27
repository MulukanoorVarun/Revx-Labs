// patient_state.dart
import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/Models/getPatientDetailModel.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/PatientDetails.dart';

import '../../../../Models/PatientsListModel.dart';

abstract class PatientState {}

class PatientInitialState extends PatientState {}

class PatientListLoadingState extends PatientState {}

class PatientDetailsLoadingState extends PatientState {}

class PatientSavingLoadingState extends PatientState {}

class PatientSuccessState extends PatientState {
  final String message;

  PatientSuccessState({required this.message});
}

class PatientLoaded extends PatientState {
  final SuccessModel successModel;
  PatientLoaded(this.successModel);
  @override
  List<Object?> get props => [successModel];
}

class PatientsListLoaded extends PatientState {
  final PatientsListModel patientsListModel;
  PatientsListLoaded(this.patientsListModel);
  @override
  List<Object?> get props => [patientsListModel];
}
class PatientsDetailsLoaded extends PatientState {
  final   getPatientDetailModel getPatientDetailsmodel;
  PatientsDetailsLoaded(this.getPatientDetailsmodel);
}

class PatientErrorState extends PatientState {
  final String errorMessage;

  PatientErrorState({required this.errorMessage});
}
