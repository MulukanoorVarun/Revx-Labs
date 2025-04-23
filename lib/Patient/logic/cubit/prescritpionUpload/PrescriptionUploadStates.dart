import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/SuccessModel.dart';

abstract class UploadPrescriptionState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadPrescriptionStateIntially extends UploadPrescriptionState {}

class UploadPrescriptionStateLoading extends UploadPrescriptionState {}

class UploadPrescriptionStateSuccessState extends UploadPrescriptionState {
  final String message;
  final SuccessModel successModel;
  UploadPrescriptionStateSuccessState(this.successModel,this.message);
  @override
  List<Object?> get props => [successModel,message];
}

class UploadPrescriptionStateError extends UploadPrescriptionState {
  final String message;
  UploadPrescriptionStateError(this.message);
}