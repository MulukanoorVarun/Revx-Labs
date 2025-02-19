import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/Vendor/VendorModel/VendorGetTestsModel.dart';

abstract class DiagnosticGetTestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DiagnosticTestsIntially extends DiagnosticGetTestsState {}

class DiagnosticTestsLoading extends DiagnosticGetTestsState {}

class DiagnosticTestListLoaded extends DiagnosticGetTestsState {

  VendorGetTestsModel data;
  DiagnosticTestListLoaded(this.data);
  List<Object?> get props => [data];
}


class DiagnosticTestsLoaded extends DiagnosticGetTestsState {
  SuccessModel data;
  DiagnosticTestsLoaded(this.data);
  List<Object?> get props => [data];
}

class DiagnosticTestsError extends DiagnosticGetTestsState {
  final String message;
  DiagnosticTestsError(this.message);
}
