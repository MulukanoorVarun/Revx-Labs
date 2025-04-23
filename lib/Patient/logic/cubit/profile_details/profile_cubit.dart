
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
 final  ProfileRepository profileRepository;
  ProfileCubit({required this.profileRepository}) : super(ProfileStateIntially());

  Future<void> getProfileDetails() async {
    emit(ProfileStateLoading());
    try {
      final profile= await profileRepository.getProfileDetails();
      if(profile!= null){
        emit(ProfileStateLoaded(profile));
      }else{
        emit(ProfileStateError(profile?.settings?.message??''));
      }
    } catch (e) {
      emit(ProfileStateError(''));
    }
  }

 Future<void> updateProfileDetails(Map<String,dynamic> data) async {
   emit(ProfileStateLoading());
   try {
     final profile= await profileRepository.updateProfileDetails(data);
     if(profile!= null){
       if(profile.settings?.success==1){
         emit(ProfileStateSuccess(profile));
         getProfileDetails();
       }else{
         emit(ProfileStateError(profile.settings?.message??''));
       }
     }else{
       emit(ProfileStateError(profile?.settings?.message??''));
     }
   } catch (e) {
     emit(ProfileStateError(''));
   }
 }
}
