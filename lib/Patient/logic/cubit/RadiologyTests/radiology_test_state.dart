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
  final bool hasNextPage;
  const RadiologyTestStateLoaded(
    this.testModel,this.hasNextPage
  );

  @override
  List<Object?> get props => [testModel,hasNextPage];
}

class RadiologyTestStateLoadingMore extends RadiologyTestState {
  final TestModel testModel;
  final bool hasNextPage;
  const RadiologyTestStateLoadingMore(this.testModel, this.hasNextPage);

  @override
  List<Object?> get props => [testModel, hasNextPage];
}

class RadiologyTestStateError extends RadiologyTestState {
  final String message;

  const RadiologyTestStateError(this.message);

  @override
  List<Object?> get props => [message];
}
