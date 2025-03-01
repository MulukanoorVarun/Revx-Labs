import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_state.dart';

import '../../repository/patient_register_repository.dart';

class PatientRegisterCubit extends Cubit<PatientRegisterState> {
  PatientRegisterRepository patientRegisterRepository;
  PatientRegisterCubit(this.patientRegisterRepository) : super(PatientRegisterIntially());

  Future<void> postRegister( Map<String,dynamic> data) async {
    emit(PatientRegisterLoading());
    try {
      final reponse = await patientRegisterRepository.postRegister(data);
      if (reponse != null) {
        if (reponse.settings?.success == 1) {
          emit(PatientRegisterSuccessState(reponse,"${reponse.settings?.message}"));
        } else {
          emit(PatientRegisterError("${reponse.settings?.message}"));
        }
      } else {
        emit(PatientRegisterError('${reponse?.settings?.message}'));
      }
    } catch (e) {
      emit(PatientRegisterError('$e'));
    }
  }
}