import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_state.dart';
import '../../../../Models/TestDetailsModel.dart';
import '../../repository/test_details_repository.dart';

class TestDetailsCubit extends Cubit<TestDetailsState> {
  final TestDetailsRepository testDetailsRepository;
  TestDetailsModel testDetailsModel = TestDetailsModel();

  TestDetailsCubit(this.testDetailsRepository) : super(TestDetailsInitial());

  /// Fetches test details for a given ID
  Future<void> getTestDetails(String id) async {
    emit(TestDetailsLoading());
    try {
      final response = await testDetailsRepository.getTestDetails(id);
      if (response?.data != null && response?.settings?.success == 1) {
        testDetailsModel = response!;
        emit(TestDetailsLoaded(testDetailsModel));
      } else {
        emit(TestDetailsError(
          response?.settings?.message ?? 'No details found for the given ID',
        ));
      }
    } catch (e) {
      emit(TestDetailsError('Failed to load test details: ${e.toString()}'));
    }
  }

  void updateTestCartStatus({required String testId, required int persons, required bool isAdded}) {
    print("Updating cart status for Test ID: $testId to $isAdded");
    if (testDetailsModel.data == null || testDetailsModel.data!.id == null) {
      emit(TestDetailsError('No test data available to update'));
      return;
    }
    if (testDetailsModel.data!.id == testId) {
      print("Updating cart status for: ${testDetailsModel.data!.id}");
      final updatedData = testDetailsModel.data!.copyWith(
        existInCart: isAdded,
        noOfPersons: persons,
      );
      testDetailsModel = TestDetailsModel(
        data: updatedData,
        settings: testDetailsModel.settings,
      );
      emit(TestDetailsLoaded(testDetailsModel));
    }
  }
}
