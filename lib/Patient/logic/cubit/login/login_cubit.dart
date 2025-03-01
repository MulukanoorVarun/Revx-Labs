

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/login/login_state.dart';
import 'package:revxpharma/Patient/logic/repository/LoginRepository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository loginRepository;
  LoginCubit(this.loginRepository)
      : super(LoginIntially());

  Future<void> postLogin( Map<String,dynamic> data) async {
    emit(LoginLoading());
    try {
      final vendor_register =
      await loginRepository.postLogin(data);
      if (vendor_register != null) {
        if (vendor_register.settings?.success == 1) {
          emit(LoginSuccessState(vendor_register,"${vendor_register.settings?.message}"));
        } else {
          emit(LoginError("${vendor_register.settings?.message}"));
        }
      } else {
        emit(LoginError('${vendor_register?.settings?.message}'));
      }
    } catch (e) {
      emit(LoginError('$e'));
    }
  }
}