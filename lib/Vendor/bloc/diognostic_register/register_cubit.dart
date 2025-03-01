import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_register/register_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_register/register_state.dart';

class VendorRegisterCubit extends Cubit<RegisterState> {
  VendorRegisterRepository vendorRegisterRepository;
  VendorRegisterCubit(this.vendorRegisterRepository)
      : super(RegisterIntially());

  Future<void> postRegister(FormData registerData) async {
    print("Register Data Fields: ${registerData.fields}");
    print("Register Data Files: ${registerData.files}");
    emit(RegisterLoading());
    try {
      final vendor_register =
      await vendorRegisterRepository.postDiognosticRegister(registerData);
      if (vendor_register != null) {
        if (vendor_register.settings?.success == 1) {
          emit(RegisterSuccessState(vendor_register,"${vendor_register.settings?.message}"));
        } else {
          emit(RegisterError("${vendor_register.settings?.message}"));
        }
      } else {
        emit(RegisterError('${vendor_register?.settings?.message}'));
      }
    } catch (e) {
      emit(RegisterError('$e'));
    }
  }
}
