
import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/LoginModel.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginIntially extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessState extends LoginState {
  final String message;
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel,this.message);
  @override
  List<Object?> get props => [loginModel,message];
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);

}