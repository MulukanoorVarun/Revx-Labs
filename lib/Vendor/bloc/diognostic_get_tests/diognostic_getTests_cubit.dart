import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_state.dart';

class DiagnosticGetTestsCubit extends Cubit<DiagnosticGetTestsState> {
  DiagnosticGetTestsRepositors diagnosticGetTestsRepositors;
  DiagnosticGetTestsCubit(this.diagnosticGetTestsRepositors) : super(DiagnosticTestsIntially());

  Future<void> getTests() async {
    final res = await diagnosticGetTestsRepositors.VendorgetTest();
    emit(DiagnosticTestsLoading());
    try {
      if (res != null) {
        emit(DiagnosticTestListLoaded(res));
      }else{
        emit(DiagnosticTestsError(res?.settings?.message??''));
      }
    } catch (e) {
      emit(DiagnosticTestsError(res?.settings?.message??''));
    }
  }
  Future<void> delateTests(id)async{
    final res= await diagnosticGetTestsRepositors.VendordelateTest(id);
    emit(DiagnosticTestsLoading());
    try{
      if(res!=null){
        emit(DiagnosticTestsLoaded(res));
      }else{
        emit(DiagnosticTestsError(res?.settings?.message??""));
      }
    }catch(e){
      emit(DiagnosticTestsError(res?.settings?.message??''));
    }
  }
}
