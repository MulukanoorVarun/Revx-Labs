import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/repository/DiagnosticDetailsRepository.dart';
import 'diagnostic_detail_state.dart';

class DiagnostocDetailCubit extends Cubit<DiagnosticDetailState> {
  final DiagnosticDetailsRepository diagnosticDetailsRepository;
  DiagnostocDetailCubit(this.diagnosticDetailsRepository) : super(DiagnosticDetailInitial());

  Future<void> fetchDiagnosticDetails(String id) async {
    emit(DiagnosticDetailLoading());
    try {
      final response = await diagnosticDetailsRepository.getDiagnosticDetails(id);
      if(response!=null){
        emit(DiagnosticDetailLoaded(response));
      }else{
        emit(DiagnosticDetailError("Failed to fetch diagnostic details"));
      }
    } catch (e) {
      emit(DiagnosticDetailError("Failed to fetch diagnostic details"));
    }
  }
}