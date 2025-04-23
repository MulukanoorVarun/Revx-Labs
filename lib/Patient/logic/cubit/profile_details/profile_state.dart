import 'package:revxpharma/Models/ProfileDetailModel.dart';
import 'package:revxpharma/Models/SuccessModel.dart';

abstract class ProfileState {}

class ProfileStateIntially extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateLoaded extends ProfileState {
  final ProfileDetailModel profileDetailModel;
  ProfileStateLoaded(this.profileDetailModel);
}

class ProfileStateSuccess extends ProfileState {
  final SuccessModel successModel;
  ProfileStateSuccess(this.successModel);
}

class ProfileStateError extends ProfileState {
  final String message;
  ProfileStateError(this.message);
}
