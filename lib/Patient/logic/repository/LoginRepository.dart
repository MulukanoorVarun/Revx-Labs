

import 'package:revxpharma/Models/LoginModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class LoginRepository {
  Future<LoginModel?> postLogin( Map<String,dynamic> data);
}

class LoginImpl implements LoginRepository {
  RemoteDataSource remoteDataSource;
  LoginImpl({required this.remoteDataSource});

  @override
  Future<LoginModel?> postLogin( Map<String,dynamic> data) async {
    return await remoteDataSource.loginApi(data);
  }
}