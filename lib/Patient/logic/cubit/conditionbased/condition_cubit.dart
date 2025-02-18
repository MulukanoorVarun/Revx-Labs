import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Models/ConditionBasedModel.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_state.dart';

class ConditionCubit extends Cubit<ConditionBasedState> {
  final ConditionRepository conditionRepository;
  ConditionCubit(this.conditionRepository) : super(ConditionBasedintially());


  Future<void> fetchConditionBased() async {
    emit(ConditionBasedLoading());
    try {
      final conditionBased = await conditionRepository.getConditionBased();
      if (conditionBased != null) {
        emit(ConditionBasedLoaded(conditionBased));
      } else {
        emit(ConditionBasedError("No test data found"));
      }
    } catch (e) {
      emit(ConditionBasedError("Failed to load test data: $e"));
    }
  }

}
