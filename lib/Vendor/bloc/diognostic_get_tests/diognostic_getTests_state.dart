import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/Vendor/VendorModel/VendorGetTestsModel.dart';

import 'package:equatable/equatable.dart';

// Base State
abstract class DiagnosticTestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class DiagnosticTestsInitially extends DiagnosticTestsState {}

// Loading State
class DiagnosticTestsLoading extends DiagnosticTestsState {}

// List Loaded State
class DiagnosticTestListLoaded extends DiagnosticTestsState {
  final VendorGetTestsModel data;
  DiagnosticTestListLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

// Single Test Loaded State
class DiagnosticTestsLoaded extends DiagnosticTestsState {
  final SuccessModel data;
  DiagnosticTestsLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

// Error State
class DiagnosticTestsError extends DiagnosticTestsState {
  final String message;
  DiagnosticTestsError(this.message);

  @override
  List<Object?> get props => [message];
}
