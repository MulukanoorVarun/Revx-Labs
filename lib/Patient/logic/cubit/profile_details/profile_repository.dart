import 'package:flutter/material.dart';
import 'package:revxpharma/Models/ProfileDetailModel.dart';
import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class ProfileRepository {
  Future<ProfileDetailModel?> getProfileDetails();
  Future<SuccessModel?> updateProfileDetails(Map<String,dynamic> data);
}

class ProfileImpl implements ProfileRepository {
  final RemoteDataSource remoteDataSource;
  ProfileImpl({required this.remoteDataSource});

  @override
  Future<ProfileDetailModel?> getProfileDetails() async {
    return await remoteDataSource.getProfileDetails();
  }

  @override
  Future<SuccessModel?> updateProfileDetails(Map<String,dynamic> data) async {
    return await remoteDataSource.updateProfileDetails(data);
  }
}
