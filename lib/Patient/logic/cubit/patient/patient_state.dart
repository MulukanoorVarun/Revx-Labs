// patient_state.dart
import 'package:revxpharma/Models/SuccessModel.dart';

abstract class PatientState {}

class PatientInitialState extends PatientState {}

class PatientLoadingState extends PatientState {}

class PatientSuccessState extends PatientState {
  final String message;  // A message to represent success

  PatientSuccessState({required this.message});
}

class PatientLoaded extends PatientState {
  final SuccessModel successModel;
  PatientLoaded(this.successModel);
  @override
  List<Object?> get props => [successModel];
}

class PatientErrorState extends PatientState {
  final String errorMessage;  // Error message from the failed operation

  PatientErrorState({required this.errorMessage});
}
