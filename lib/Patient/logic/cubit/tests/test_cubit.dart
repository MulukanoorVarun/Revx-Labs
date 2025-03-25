import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

class TestCubit extends Cubit<TestState> {

  final TestRepository testRepository;
  TestModel testModel=TestModel();

  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;

  TestCubit(this.testRepository) : super(TestStateInitially());

  Future<void> fetchTestList(String latlang, String catId, String searchQuery, String diagnosticID) async {
    emit(TestStateLoading());
    _currentPage = 1;
    try {
      final tests = await testRepository.getTest(latlang, catId, searchQuery, _currentPage, diagnosticID);
      if (tests != null) {
        testModel = tests;
        _hasNextPage = tests.settings?.nextPage ?? false;
        emit(TestStateLoaded(tests, _hasNextPage));
      } else {
        emit(TestStateError("No test data found"));
      }
    } catch (e) {
      emit(TestStateError("Failed to load test data: $e"));
    }
  }

  Future<void> fetchMoreTestList(String latlang, String catId, String searchQuery, String diagnosticID) async {
    if (_isLoadingMore || !_hasNextPage) return;
    _isLoadingMore = true;
    _currentPage++;
    emit(TestStateLoadingMore(testModel, _hasNextPage));

    try {
      final newTests = await testRepository.getTest(latlang, catId, searchQuery, _currentPage, diagnosticID);
      if (newTests != null && newTests.data!.isNotEmpty) {
        final updatedTests = List<Data>.from(testModel!.data!)..addAll(newTests.data!);
        testModel = TestModel(data: updatedTests, settings: newTests.settings);
        _hasNextPage = newTests.settings?.nextPage ?? false;
        emit(TestStateLoaded(testModel, _hasNextPage));
      }
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      _isLoadingMore = false;
    }
  }

  void updateTestCartStatus({required String testId, required bool isAdded}) {
    print("Updating cart status for Test ID: $testId to $isAdded");

    if (testModel.data != null) {
      final updatedTests = List<Data>.from(testModel.data!.map((test) {
        if (test.id == testId) {
          print("Updating cart status for: ${test.id}");
          return test.copyWith(existInCart: isAdded);
        }
        return test;
      }));

      testModel = TestModel(
        data: updatedTests,
        settings: testModel.settings,
      );

      emit(TestStateLoaded(testModel, _hasNextPage));
    }
  }
}