import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/TestModel.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object?> get props => [];
}

class TestStateInitially extends TestState {}

class TestStateLoading extends TestState {}

class TestStateLoaded extends TestState {
  final TestModel testModel;
  final bool hasNextPage; // Tracks if more data is available

  const TestStateLoaded(this.testModel, this.hasNextPage);

  @override
  List<Object?> get props => [testModel, hasNextPage];
}

class TestStateLoadingMore extends TestState {
  final TestModel testModel;
  final bool hasNextPage; // Tracks if more data is available
  const TestStateLoadingMore(this.testModel,this.hasNextPage);

  @override
  List<Object?> get props => [testModel];
}

class TestStateError extends TestState {
  final String message;

  const TestStateError(this.message);

  @override
  List<Object?> get props => [message];
}

