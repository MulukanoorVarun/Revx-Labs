import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/TestModel.dart';

abstract class RegularTestState extends Equatable {
  const RegularTestState();

  @override
  List<Object?> get props => [];
}

class RegularTestInitial extends RegularTestState {
  const RegularTestInitial();
}

class RegularTestLoading extends RegularTestState {
  const RegularTestLoading();
}

class RegularTestLoaded extends RegularTestState {
  final TestModel testModel;
  final bool hasNextPage;

  const RegularTestLoaded(this.testModel, this.hasNextPage);

  @override
  List<Object?> get props => [testModel, hasNextPage];
}
class RegularTestStateLoadingMore extends RegularTestState {
  final TestModel testModel;
  final bool hasNextPage;
  const RegularTestStateLoadingMore(this.testModel, this.hasNextPage);

  @override
  List<Object?> get props => [testModel, hasNextPage];
}

class RegularTestStateError extends RegularTestState {
  final String message;

  const RegularTestStateError(this.message);

  @override
  List<Object?> get props => [message];
}