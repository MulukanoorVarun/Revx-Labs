import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_register/register_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_register/register_state.dart';

class VendorRegisterCubit extends Cubit<RegisterState> {
  VendorRegisterRepository vendorRegisterRepository;
  VendorRegisterCubit(this.vendorRegisterRepository)
      : super(RegisterIntially());

  Future<void> postRegister(
      String contactPersonName,
      String diagnosticName,
      String completeAddress,
      String contactNumber,
      String email,
      String pwd,
      List<String> daysOpened,
      String startTime,
      String endTime,
      String registrationNumber) async {
    emit(RegisterLoading());
    try {
      final vendor_registor =
          await vendorRegisterRepository.postDiognosticRegister(
        contactPersonName,
        diagnosticName,
        completeAddress,
        contactNumber,
        email,
        pwd,
        daysOpened,
        startTime,
        endTime,
        registrationNumber,
      );
      if (vendor_registor != null) {
        emit(RegisterSuccessState('${vendor_registor.settings?.status}'));
      } else {
        emit(RegisterError('${vendor_registor?.settings?.message}'

        ));
      }
    } catch (e) {
      emit(RegisterError( '${e}'));
    }
  }
}
