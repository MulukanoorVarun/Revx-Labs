import '../../../../Models/LoginModel.dart';
import '../../../../data/api_routes/remote_data_source.dart';

abstract class Deleteaccountrepository {
  Future<LoginModel?> deleteAccount();
}

class DeleteaccountrepositoryImpl implements Deleteaccountrepository {
  RemoteDataSource remoteDataSource;
  DeleteaccountrepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginModel?> deleteAccount() async {
    return await remoteDataSource.deleteAccount();
  }
}