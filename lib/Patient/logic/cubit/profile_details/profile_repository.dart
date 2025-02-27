import 'package:revxpharma/Models/ProfileDetailModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class ProfileRepository {
  Future<ProfileDetailModel?> getProfileDetails();
}

class ProfileImpl extends ProfileRepository {
  final RemoteDataSource remoteDataSource;
  ProfileImpl({required this.remoteDataSource});

  @override
  Future<ProfileDetailModel?> getProfileDetails() async {
    return await remoteDataSource.getProfileDetails();
  }
}
