import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_state.dart';

class DiagnosticGetTestsCubit extends Cubit<DiagnosticGetTestsState> {
  DiagnosticGetTestsRepositors diagnosticGetTestsRepositors;
  DiagnosticGetTestsCubit(this.diagnosticGetTestsRepositors)
      : super(DiagnosticGetTestsIntially());

  Future<void> getTests() async {
    final res = await diagnosticGetTestsRepositors.VendorgetTest();
    emit(DiagnosticGetTestsLoading());
    try {
      if (res != null) {
        if (res.settings?.success == 1) {
          emit(DiagnosticGetTestsLoaded(res));
        } else {
          emit(DiagnosticGetTestsError(res.settings?.message??''));
        }
      }
      emit(DiagnosticGetTestsError(res?.settings?.message??''));
    } catch (e) {
      emit(DiagnosticGetTestsError(res?.settings?.message??''));
    }
  }
}
