import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_state.dart';

class DiagnosticGetTestsCubit extends Cubit<DiagnosticGetTestsState> {
  DiagnosticGetTestsRepositors diagnosticGetTestsRepositors;
  DiagnosticGetTestsCubit({required this.diagnosticGetTestsRepositors})
      : super(DiagnosticTestsIntially());

  Future<void> getTests() async {
    emit(DiagnosticTestsLoading());
    final res = await diagnosticGetTestsRepositors.VendorgetTest();

    try {
      if (res != null) {
        emit(DiagnosticTestListLoaded(res));
      } else {
        emit(DiagnosticTestsError(res?.settings?.message ?? ''));
      }
    } catch (e) {
      emit(DiagnosticTestsError(res?.settings?.message ?? ''));
    }
  }

  Future<void> delateTests(id) async {
    emit(DiagnosticTestsLoading());
    final res = await diagnosticGetTestsRepositors.VendordelateTest(id);

    try {
      if (res != null) {
        emit(DiagnosticTestsLoaded(res));
      } else {
        emit(DiagnosticTestsError(res?.settings?.message ?? ""));
      }
    } catch (e) {
      emit(DiagnosticTestsError(res?.settings?.message ?? ''));
    }
  }
}
