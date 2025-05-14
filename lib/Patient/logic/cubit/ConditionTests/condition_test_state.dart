import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/TestModel.dart';

import '../../../../Models/ConditionModel.dart';

abstract class ConditionTestState extends Equatable {
  const ConditionTestState();

  @override
  List<Object?> get props => [];
}

class ConditionTestStateInitially extends ConditionTestState {}

class ConditionTestStateLoading extends ConditionTestState {}

class ConditionTestStateLoaded extends ConditionTestState {
  final ConditionModel conditionModel;

  const ConditionTestStateLoaded(
    this.conditionModel,
  );

  @override
  List<Object?> get props => [conditionModel];
}

class ConditionTestStateError extends ConditionTestState {
  final String message;

  const ConditionTestStateError(this.message);

  @override
  List<Object?> get props => [message];
}
