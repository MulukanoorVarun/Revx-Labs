import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_state.dart';

class RadiologyTestCubit extends Cubit<RadiologyTestState> {
  final RadiologyTestRepository radiologyTestRepository;
  TestModel testModel = TestModel();

  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;

  RadiologyTestCubit(this.radiologyTestRepository)
      : super(RadiologyTestStateInitially());

  Future<void> fetchRadiologyTests(
      String latlang,
      String catId,
      String searchQuery,
      String diagnosticID,
      String scanId,
      String x_rayId,
      page) async {
    emit(RadiologyTestStateLoading());
    _currentPage = 1;
    try {
      final tests = await radiologyTestRepository.getRadiologyTest(latlang,
          catId, searchQuery, _currentPage, diagnosticID, scanId, x_rayId);
      if (tests != null) {
        testModel = tests;
        _hasNextPage = tests.settings?.nextPage ?? false;
        emit(RadiologyTestStateLoaded(tests,_hasNextPage));
      } else {
        emit(RadiologyTestStateError("No test data found"));
      }
    } catch (e) {
      emit(RadiologyTestStateError("Failed to load test data: $e"));
    }
  }

  Future<void> fetchRadiologyTestsMore(
      String latlang,
      String catId,
      String conditionId,
      String searchQuery,
      String diagnosticID,
      String scanId,
      String x_rayId) async {
    if (_isLoadingMore || !_hasNextPage) return;
    _isLoadingMore = true;
    _currentPage++;
    emit(RadiologyTestStateLoadingMore(testModel, _hasNextPage));

    try {
      final tests = await radiologyTestRepository.getRadiologyTest(latlang,
          catId, searchQuery, _currentPage, diagnosticID, scanId, x_rayId);
      if (tests != null && tests.data!.isNotEmpty) {
        final updatedTests = List<Data>.from(testModel.data!)
          ..addAll(tests.data!);
        testModel = TestModel(data: updatedTests, settings: tests.settings);
        _hasNextPage = tests.settings?.nextPage ?? false;
        emit(RadiologyTestStateLoaded(testModel, _hasNextPage));
      }
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      _isLoadingMore = false;
    }
  }
}
