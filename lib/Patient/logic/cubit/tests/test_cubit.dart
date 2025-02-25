import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

import '../../../../Models/TestModel.dart';

class TestCubit extends Cubit<TestState> {
  final TestRepository testRepository;
  TestModel? testModel;  // Store the fetched test list for easy manipulation

  TestCubit(this.testRepository) : super(TestStateInitially());

  // Fetch Test List
  Future<void> fetchTestList(String latlang, String catId) async {
    emit(TestStateLoading());
    try {
      final tests = await testRepository.getTest(latlang, catId);
      if (tests != null) {
        testModel = tests;  // Store the test list
        emit(TestStateLoaded(tests));
      } else {
        emit(TestStateError("No test data found"));
      }
    } catch (e) {
      emit(TestStateError("Failed to load test data: $e"));
    }
  }

  void updateTestCartStatus({required String testId, required bool isAdded}) {
    print("is in cart Status: $isAdded");
    if (testModel?.data != null) {
      final updatedTests = testModel!.data!.map((test) {
        if (test.id == testId) {
          print("Updating cart status for: ${test.id}");
          return test.copyWith(exist_in_cart: isAdded);
        }
        return test;
      }).toList();

      // ✅ Create a new TestModel instance to trigger UI rebuild
      final updatedTestModel = TestModel(
        data: updatedTests,
        settings: testModel!.settings,
      );

      print("Cart status after update: ${updatedTests.firstWhere((test) => test.id == testId).exist_in_cart}");
      // ✅ Emit new state with new instance
      emit(TestStateLoaded(updatedTestModel));
    }
  }


}

