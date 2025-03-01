
import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/SuccessModel.dart';

abstract class PatientRegisterState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PatientRegisterIntially extends PatientRegisterState {}

class PatientRegisterLoading extends PatientRegisterState {}

class PatientRegisterSuccessState extends PatientRegisterState {
  final String message;
  final SuccessModel successModel;
  PatientRegisterSuccessState(this.successModel,this.message);
  @override
  List<Object?> get props => [successModel,message];
}

class PatientRegisterError extends PatientRegisterState {
  String message;
  PatientRegisterError(this.message);

}