import 'package:revxpharma/Models/LoginModel.dart';
import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class PatientRegisterRepository {
  Future<SuccessModel?> postRegister( Map<String,dynamic> data);
}

class PatientRegisterImpl implements PatientRegisterRepository {
  RemoteDataSource remoteDataSource;
  PatientRegisterImpl({required this.remoteDataSource});

  @override
  Future<SuccessModel?> postRegister( Map<String,dynamic> data) async {
    return await remoteDataSource.registerApi(data);
  }

}