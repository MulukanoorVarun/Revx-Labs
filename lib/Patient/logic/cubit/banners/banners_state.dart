import 'package:equatable/equatable.dart';
import '../../../../Models/BannersModel.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object?> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final BannersModel banners;
  const BannerLoaded(this.banners);

  @override
  List<Object?> get props => [banners];
}

class BannerError extends BannerState {
  final String message;
  const BannerError(this.message);

  @override
  List<Object?> get props => [message];
}
