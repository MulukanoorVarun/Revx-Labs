import 'package:dio/dio.dart';
import 'package:revxpharma/Vendor/VendorModel/VendorGetTestsModel.dart';
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
  Future<VendorGetTestsModel?> DiagnosticgetTests();
  Future<SuccessModel?> DiagnosticDelateTest(String id);
}

class VendorRemoteDataSourceImpl implements VendorRemoteDataSource {
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
  ) async {
    try {
      Response response =
          await ApiClient.post('${VendorRemoteUrls.vendorRegister}');
      if (response.statusCode == 200) {
        LogHelper.printLog('postDiognosticRegister', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error postDiognosticRegister data: $e");
      return null;
    }
  }

  Future<VendorGetTestsModel?> DiagnosticgetTests() async {
    try {
      Response response =
          await ApiClient.get('${VendorRemoteUrls.vendorGetTests}');
      if (response.statusCode == 200) {
        LogHelper.printLog('DiagnosticgetTests', response.data);
        return VendorGetTestsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error DiagnosticgetTests data: $e");
      return null;
    }
  }

  Future<SuccessModel?> DiagnosticDelateTest(String id) async {
    try {
      Response response =
          await ApiClient.delete('${VendorRemoteUrls.vendorDeleteTests}/${id}');
      if (response.statusCode == 200) {
        LogHelper.printLog('DiagnosticDelateTest', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error DiagnosticDelateTest data: $e");
    }
  }
}
