import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/repository/DiagnosticDetailsRepository.dart';
import 'diagnostic_detail_state.dart';

class DiagnostocDetailCubit extends Cubit<DiagnosticDetailState> {
  final DiagnosticDetailsRepository diagnosticDetailsRepository;

  DiagnostocDetailCubit(this.diagnosticDetailsRepository) : super(DiagnosticDetailInitial());

  Future<void> fetchDiagnosticDetails(String id) async {
    emit(DiagnosticDetailLoading());
    try {
      final banners = await diagnosticDetailsRepository.getDiagnosticDetails(id); // ✅ Correct method call
      emit(DiagnosticDetailLoaded(banners!));
    } catch (e) {
      emit(DiagnosticDetailError("Failed to fetch diagnostic details"));
    }
  }
}