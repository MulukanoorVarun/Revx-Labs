import 'package:equatable/equatable.dart';

import '../../../Models/SuccessModel.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterIntially extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String message;
  final SuccessModel successModel;
  RegisterSuccessState(this.successModel,this.message);
  @override
  List<Object?> get props => [successModel,message];
}

class RegisterError extends RegisterState {
  String message;
  RegisterError(this.message);

}
