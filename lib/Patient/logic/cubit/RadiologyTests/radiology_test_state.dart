import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/TestModel.dart';

abstract class RadiologyTestState extends Equatable {
  const RadiologyTestState();

  @override
  List<Object?> get props => [];
}

class RadiologyTestStateInitially extends RadiologyTestState {}

class RadiologyTestStateLoading extends RadiologyTestState {}

class RadiologyTestStateLoaded extends RadiologyTestState {
  final TestModel testModel;

  const RadiologyTestStateLoaded(this.testModel,);

  @override
  List<Object?> get props => [testModel];
}

class RadiologyTestStateError extends RadiologyTestState {
  final String message;

  const RadiologyTestStateError(this.message);

  @override
  List<Object?> get props => [message];
}

