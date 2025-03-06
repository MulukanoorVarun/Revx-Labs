import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_state.dart';
import '../../repository/test_details_repository.dart';

class TestDetailsCubit extends Cubit<TestDetailsState> {
  final TestDetailsRepository testDetailsRepository;

  TestDetailsCubit(this.testDetailsRepository) : super(TestDetailsInitial());

  Future<void> getTestDetails(String id) async {
    emit(TestDetailsLoading());
    try {
      final response = await testDetailsRepository.getTestDetails(id);
      if (response != null) {
        emit(TestDetailsLoaded(response));
      } else {
        emit(TestDetailsError("${response?.settings?.message?? 'No details found for the given ID'}"));
      }
    } catch (e) {
      emit(TestDetailsError(e.toString()));
    }
  }
}
