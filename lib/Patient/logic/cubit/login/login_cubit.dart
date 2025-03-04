

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/login/login_state.dart';
import 'package:revxpharma/Patient/logic/repository/LoginRepository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository loginRepository;

  LoginCubit(this.loginRepository)
      : super(LoginIntially());

  Future<void> postLogin(Map<String, dynamic> data) async {
    emit(LoginLoading());
    try {
      final vendorRegister = await loginRepository.postLogin(data);

      if (vendorRegister != null) {
        if (vendorRegister.settings?.success == 1) {
          emit(LoginSuccessState(vendorRegister,
              vendorRegister.settings?.message ?? "Login successful!"));
        } else {
          emit(LoginError("Invalid credentials. Please try again."));
        }
      } else {
        emit(LoginError("Unexpected error occurred. Please try again later."));
      }
    } catch (e) {
      emit(LoginError(
          "An error occurred while logging in. Please check your network connection and try again."));
    }
  }
}
