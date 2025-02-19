import 'package:dio/dio.dart';
import 'package:revxpharma/data/api_routes/vendor_remote_urls.dart';
import '../../Components/debugPrint.dart';
import '../../Models/SuccessModel.dart';
import '../../Services/ApiClient.dart';

abstract class VendorRemoteDataSource {
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

class VendorRemoteDataSourceImpl implements VendorRemoteDataSource {

  Future<SuccessModel?>postDiognosticRegister(
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
      )async {
    try {
      Response response = await ApiClient.post('${VendorRemoteUrls.vendorRegister}');
      if (response.statusCode == 200) {
        LogHelper.printLog('postDiognosticRegister', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error DeletePatient data: $e");
      return null;
    }
  }

}