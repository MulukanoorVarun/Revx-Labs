import 'package:dio/dio.dart';
import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/data/api_routes/remote_data_source.dart';

abstract class VendorRegisterRepository {
  Future<SuccessModel?> postDiognosticRegister(
    String contactPersonName,
    String diagnosticName,
    String completeAddress,
    String contactNumber,
    String email,
    String pwd,
    List<String> daysOpened,
    String startTime,
    String endTime,
    String registrationNumber,
  );
}

class VendorRegisterImpl extends VendorRegisterRepository {
  RemoteDataSource remoteDataSource;
  VendorRegisterImpl({required this.remoteDataSource});
  @override
  Future<SuccessModel?> postDiognosticRegister(
      String contactPersonName,
      String diagnosticName,
      String completeAddress,
      String contactNumber,
      String email,
      String pwd,
      List<String> daysOpened,
      String startTime,
      String endTime,
      String registrationNumber) async {

    return await remoteDataSource.postDiognosticRegister(
        contactPersonName,
        diagnosticName,
        completeAddress,
        contactNumber,
        email,
        pwd,
        daysOpened,
        startTime,
        endTime,
        registrationNumber);
  }
}
