import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/RegularTest/regular_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

class RegularTestCubit extends Cubit<TestState> {

  final RegularTestRepository regularTestRepository;
  TestModel testModel=TestModel();

  int _currentPage = 1;
  bool _hasNextPage = true;


  RegularTestCubit(this.regularTestRepository) : super(TestStateInitially());

  Future<void> fetchTestList(String latlang, String catId, String searchQuery, String diagnosticID,String scanId,String x_rayId) async {
    emit(TestStateLoading());
    _currentPage = 1;
    try {
      final tests = await regularTestRepository.getRegularTest(latlang, catId, searchQuery, _currentPage,diagnosticID,scanId,x_rayId);
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


}