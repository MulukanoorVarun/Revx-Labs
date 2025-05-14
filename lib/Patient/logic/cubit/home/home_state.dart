
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final CategoryModel categories;
  final BannersModel banners;
  final DiognisticCenterModel diagnosticCenters;
  final ProfileDetailModel prfileDetails;
  final TestModel regulartestModel;
  final TestModel radiologyTestModel;
  final ConditionModel conditionModel;


  const HomeLoaded(this.categories, this.banners, this.diagnosticCenters,this.prfileDetails,this.regulartestModel,this.radiologyTestModel,this.conditionModel,);

  @override
  List<Object?> get props => [categories, banners, diagnosticCenters, prfileDetails,regulartestModel,radiologyTestModel,conditionModel,];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
