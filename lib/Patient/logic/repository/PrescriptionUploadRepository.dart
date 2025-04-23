import 'package:revxpharma/Models/SuccessModel.dart';

import '../../../data/api_routes/remote_data_source.dart';

abstract class PrescriptionUploadRepository {
  Future<SuccessModel?> postUploadPrescription( Map<String,dynamic> data);
}

class PrescriptionUploadRepositoryImpl implements PrescriptionUploadRepository {
  RemoteDataSource remoteDataSource;
  PrescriptionUploadRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SuccessModel?> postUploadPrescription( Map<String,dynamic> data) async {
    return await remoteDataSource.uploadPrescription(data);
  }
}