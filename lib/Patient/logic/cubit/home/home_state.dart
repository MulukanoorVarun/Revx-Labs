
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

  const HomeLoaded(this.categories, this.banners, this.diagnosticCenters,this.prfileDetails);

  @override
  List<Object?> get props => [categories, banners, diagnosticCenters, prfileDetails];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
