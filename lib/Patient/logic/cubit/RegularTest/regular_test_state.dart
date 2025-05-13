import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/TestModel.dart';

/// Abstract base class for regular test states.
abstract class RegularTestState extends Equatable {
  const RegularTestState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any test data is loaded.
class RegularTestInitial extends RegularTestState {
  const RegularTestInitial();
}

/// State when test data is being loaded.
class RegularTestLoading extends RegularTestState {
  const RegularTestLoading();
}

/// State when test data is successfully loaded.
class RegularTestLoaded extends RegularTestState {
  final TestModel testModel;
  final bool hasNextPage; // Tracks if more data is available

  const RegularTestLoaded(this.testModel, this.hasNextPage);

  @override
  List<Object?> get props => [testModel, hasNextPage];
}

/// State when an error occurs during test data loading.
class RegularTestStateError extends RegularTestState {
  final String message;

  const RegularTestStateError(this.message);

  @override
  List<Object?> get props => [message];
}