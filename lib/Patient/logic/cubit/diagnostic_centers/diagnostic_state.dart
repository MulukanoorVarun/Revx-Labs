import 'package:equatable/equatable.dart';

import '../../../../Models/DiognisticCenterModel.dart';

abstract class DiagnosticCentersState extends Equatable {
  const DiagnosticCentersState();

  @override
  List<Object?> get props => [];
}

class DiagnosticCentersInitial extends DiagnosticCentersState {}

class DiagnosticCentersLoading extends DiagnosticCentersState {}

class DiagnosticCentersLoaded extends DiagnosticCentersState { // ✅ Fixed class name
  final DiognisticCenterModel diagnosticCenters;
  const DiagnosticCentersLoaded(this.diagnosticCenters);

  @override
  List<Object?> get props => [diagnosticCenters]; // ✅ Correct variable name
}

class DiagnosticCentersError extends DiagnosticCentersState {
  final String message;
  const DiagnosticCentersError(this.message);

  @override
  List<Object?> get props => [message];
}
