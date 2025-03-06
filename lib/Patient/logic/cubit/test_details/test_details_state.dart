import 'package:revxpharma/Models/TestDetailsModel.dart';

abstract class TestDetailsState{

}

class TestDetailsInitial extends TestDetailsState{}

class TestDetailsLoading extends TestDetailsState{}

class TestDetailsLoaded extends TestDetailsState{
  final TestDetailsModel testDetailsModel;
  TestDetailsLoaded(this.testDetailsModel);
}

class TestDetailsError extends TestDetailsState{
  final String error;
  TestDetailsError(this.error);
}