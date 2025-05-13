import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_state.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

class RadiologyTestCubit extends Cubit<RadiologyTestState> {
  final RadiologyTestRepository radiologyTestRepository;
  TestModel testModel = TestModel();

  RadiologyTestCubit(this.radiologyTestRepository)
      : super(RadiologyTestStateInitially());

  Future<void> fetchTestList(String latlang, String catId, String searchQuery,
      String diagnosticID, String scanId, String x_rayId) async {
    emit(RadiologyTestStateLoading());

    try {
      final tests = await radiologyTestRepository.getRadiologyTest(
        latlang,
      );
      if (tests != null) {
        testModel = tests;
        emit(RadiologyTestStateLoaded(tests));
      } else {
        emit(RadiologyTestStateError("No test data found"));
      }
    } catch (e) {
      emit(RadiologyTestStateError("Failed to load test data: $e"));
    }
  }
}
