import 'package:equatable/equatable.dart';
import '../../../../Models/LoginModel.dart';

abstract class DeleteAccountState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteAccountIntially extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccessState extends DeleteAccountState {
  final String message;
  final LoginModel loginModel;
  DeleteAccountSuccessState(this.loginModel,this.message);
  @override
  List<Object?> get props => [loginModel,message];
}

class DeleteAccountError extends DeleteAccountState {
  final String message;
  DeleteAccountError(this.message);

}