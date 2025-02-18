import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

class TestCubit extends Cubit<TestState> {
  final TestRepository testRepository;
  TestCubit(this.testRepository) : super(TestStateInitially());

  Future<void> fetchTestList(String latlang,catId) async {
    emit(TestStateLoading());
    try {
      final tests = await testRepository.getTest(latlang,catId);
      if (tests != null) {
        emit(TestStateLoaded(tests));
      } else {
        emit(TestStateError("No test data found"));
      }
    } catch (e) {
      emit(TestStateError("Failed to load test data: $e"));
    }
  }
}
