import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/RegularTest/regular_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/RegularTest/regular_test_state.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

class RegularTestCubit extends Cubit<RegularTestState> {
  final RegularTestRepository regularTestRepository;
  TestModel testModel = TestModel();

  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;

  RegularTestCubit(this.regularTestRepository) : super(RegularTestInitial());

  Future<void> fetchRegularTestList(
      String latlang,
      String catId,
      String searchQuery,
      String diagnosticID,
      String scanId,
      String x_rayId,page) async {
    emit(RegularTestLoading());
    _currentPage = 1;
    try {
      final tests = await regularTestRepository.getRegularTest(latlang, catId,
          searchQuery, _currentPage, diagnosticID, scanId, x_rayId);
      if (tests != null) {
        if (tests.settings?.success == 1) {
          testModel = tests;
          _hasNextPage = tests.settings?.nextPage ?? false;
          emit(RegularTestLoaded(tests, _hasNextPage));
        } else {
          emit(RegularTestStateError("No test data found"));
        }
      } else {
        emit(RegularTestStateError("No test data found"));
      }
    } catch (e) {
      emit(RegularTestStateError("Failed to load test data: $e"));
    }
  }

  Future<void> fetchRegularTestsMore(
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
    emit(RegularTestStateLoadingMore(testModel, _hasNextPage));

    try {
      final tests = await regularTestRepository.getRegularTest(latlang, catId,
          searchQuery, _currentPage, diagnosticID, scanId, x_rayId);
      if (tests != null && tests.data!.isNotEmpty) {
        if (tests.settings?.success == 1) {
          final updatedTests = List<Data>.from(testModel.data!)
            ..addAll(tests.data!);
          testModel = TestModel(data: updatedTests, settings: tests.settings);
          _hasNextPage = tests.settings?.nextPage ?? false;
          emit(RegularTestLoaded(testModel, _hasNextPage));
        } else {
          emit(RegularTestStateError("No test data found"));
        }
      } else {
        emit(RegularTestStateError("No test data found"));
      }
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      _isLoadingMore = false;
    }
  }
}
