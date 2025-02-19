import 'package:equatable/equatable.dart';
import 'package:revxpharma/Vendor/VendorModel/VendorGetTestsModel.dart';

abstract class DiagnosticGetTestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DiagnosticGetTestsIntially extends DiagnosticGetTestsState {}

class DiagnosticGetTestsLoading extends DiagnosticGetTestsState {}

class DiagnosticGetTestsLoaded extends DiagnosticGetTestsState {
  VendorGetTestsModel data;
  DiagnosticGetTestsLoaded(this.data);

  List<Object?> get props => [data];
}

class DiagnosticGetTestsError extends DiagnosticGetTestsState {
  final String message;
  DiagnosticGetTestsError(this.message);

}
