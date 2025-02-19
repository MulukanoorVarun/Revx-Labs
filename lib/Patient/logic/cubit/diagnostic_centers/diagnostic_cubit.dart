import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/diagnostic_center_repository.dart';
import 'diagnostic_state.dart';

class DiagnosticCentersCubit extends Cubit<DiagnosticCentersState> {
  final DiagnosticCenterRepository diagnosticCentersRepository;

  DiagnosticCentersCubit(this.diagnosticCentersRepository) : super(DiagnosticCentersInitial());

  Future<void> fetchDiagnosticCenters(latlng) async {
    emit(DiagnosticCentersLoading());
    try {
      final diagnosticCenters = await diagnosticCentersRepository.getDiagnosticCenters(latlng);
      if(diagnosticCenters!=null){
        emit(DiagnosticCentersLoaded(diagnosticCenters));
      }else{
        emit(DiagnosticCentersError("Failed to fetch diagnostic centers"));
      }
    } catch (e) {
      emit(DiagnosticCentersError("Failed to fetch diagnostic centers"));
    }
  }
}

