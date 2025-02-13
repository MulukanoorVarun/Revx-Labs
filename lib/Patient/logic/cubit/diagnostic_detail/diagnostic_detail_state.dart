import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';

abstract class DiagnosticDetailState extends Equatable {
  const DiagnosticDetailState();

  @override
  List<Object?> get props => [];
}

class  DiagnosticDetailInitial extends DiagnosticDetailState {}

class  DiagnosticDetailLoading extends DiagnosticDetailState {}

class  DiagnosticDetailLoaded extends DiagnosticDetailState {
  final DiognisticDetailModel diagnostic_details;
  const  DiagnosticDetailLoaded(this.diagnostic_details);

  @override
  List<Object?> get props => [diagnostic_details];
}

class  DiagnosticDetailError extends DiagnosticDetailState {
  final String message;
  const  DiagnosticDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
