// patient_state.dart
abstract class PatientState {}

class PatientInitialState extends PatientState {}

class PatientLoadingState extends PatientState {}

class PatientSuccessState extends PatientState {
  final String message;  // A message to represent success

  PatientSuccessState({required this.message});
}

class PatientErrorState extends PatientState {
  final String errorMessage;  // Error message from the failed operation

  PatientErrorState({required this.errorMessage});
}
