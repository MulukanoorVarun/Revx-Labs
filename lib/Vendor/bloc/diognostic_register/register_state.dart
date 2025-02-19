import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterIntially extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  String message;
  RegisterSuccessState(this.message);
}

class RegisterError extends RegisterState {
  String message;
  RegisterError(this.message);

}
