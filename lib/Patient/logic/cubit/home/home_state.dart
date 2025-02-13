
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {} // 🔄 Shows a loading state until all data is fetched

class HomeLoaded extends HomeState {
  final CategoryModel categories;
  final BannersModel banners;
  final DiognisticCenterModel diagnosticCenters;

  const HomeLoaded(this.categories, this.banners, this.diagnosticCenters);

  @override
  List<Object?> get props => [categories, banners, diagnosticCenters];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
