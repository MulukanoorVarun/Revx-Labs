import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/ConditionBasedModel.dart';

abstract class ConditionBasedState extends Equatable {
  const ConditionBasedState();

  @override
  List<Object?> get props => [];
}

class ConditionBasedintially extends ConditionBasedState {}

class ConditionBasedLoading extends ConditionBasedState {}

class ConditionBasedLoaded extends ConditionBasedState {
  final ConditionBasedModel conditionBasedModel;
  ConditionBasedLoaded(this.conditionBasedModel);
  @override
  List<Object?> get props => [conditionBasedModel];
}

class ConditionBasedError extends ConditionBasedState {
  final String message;
  ConditionBasedError(this.message);

  @override
  List<Object?> get props => [message];
}
