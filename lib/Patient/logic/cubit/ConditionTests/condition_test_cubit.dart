import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';
import '../../../../Models/ConditionModel.dart';
import 'condition_test_repository.dart';
import 'condition_test_state.dart';

class ConditionTestCubit extends Cubit<ConditionTestState> {
  final ConditionTestRepository conditiontestRepository;
  ConditionTestCubit(this.conditiontestRepository)
      : super(ConditionTestStateInitially());

  Future<void> fetchConditionTestList() async {
    emit(ConditionTestStateLoading());
    try {
      final res = await conditiontestRepository.getConditionTest();
      if (res != null) {
        if (res.settings?.success == 1) {
          emit(ConditionTestStateLoaded(res));
        } else {
          emit(ConditionTestStateError(res.settings?.message ?? ""));
        }
      } else {
        emit(ConditionTestStateError(res?.settings?.message ?? ""));
      }
    } catch (e) {
      emit(ConditionTestStateError("Failed to load test data: $e"));
    }
  }
}
