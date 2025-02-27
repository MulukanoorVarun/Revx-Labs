import 'package:revxpharma/Models/ProfileDetailModel.dart';

abstract class ProfileState{

}
class ProfileStateIntially extends ProfileState{

}
class ProfileStateLoading extends ProfileState{

}
class ProfileStateLoaded extends ProfileState{
  final   ProfileDetailModel profileDetailModel;
  ProfileStateLoaded(this.profileDetailModel);

}
class ProfileStateError extends ProfileState{
  final String message;
  ProfileStateError(this.message);


}