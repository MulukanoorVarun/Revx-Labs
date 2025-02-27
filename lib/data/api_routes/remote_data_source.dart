import 'package:dio/dio.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Models/CartListModel.dart';
import 'package:revxpharma/Models/ConditionBasedModel.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Models/getPatientDetailModel.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/data/api_routes/patient_remote_url.dart';

import '../../Components/debugPrint.dart';
import '../../Models/CategoryModel.dart';
import '../../Models/DiognisticCenterModel.dart';
import '../../Models/PatientsListModel.dart';
import '../../Models/SuccessModel.dart';

abstract class RemoteDataSource {
  Future<CategoryModel?> fetchCategories();
  Future<BannersModel?> fetchBanners();
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng);
  Future<DiognisticDetailModel?> fetchDiagnosticDetails(id);
  Future<TestModel?> fetchTest(latlang, catId,page);
  Future<ConditionBasedModel?> fetchConditionBased();
  Future<PatientsListModel?> fetchPatients();
  Future<SuccessModel?> AddPatient(Map<String, dynamic> patientData);
  Future<SuccessModel?> UpdatePatient(Map<String, dynamic> patientData,id);
  Future<SuccessModel?> DeletePatient(id);
  Future<getPatientDetailModel?> GetPatientDetails(id);
  Future<CartListModel?> fetchCartList();
  Future<SuccessModel?> AddToCart(Map<String, dynamic> Data);
  Future<SuccessModel?> RemoveFromCart(id);
}

class RemoteDataSourceImpl implements RemoteDataSource {

  @override
  Future<SuccessModel?> RemoveFromCart(id) async {
    try {
      Response response = await ApiClient.delete("${PatientRemoteUrls.removeCart}/${id}");
      if (response.statusCode == 200) {
        LogHelper.printLog('RemoveFromCart:',  response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error RemoveFromCart::',e);
      return null;
    }
  }

  @override
  Future<SuccessModel?> AddToCart(Map<String, dynamic> Data) async {
    try {
      Response response = await ApiClient.post(PatientRemoteUrls.addToCart,data: Data);
      if (response.statusCode == 200) {
        LogHelper.printLog('AddToCart:',  response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error Add to cart::',e);
      return null;
    }
  }

  @override
  Future<CartListModel?> fetchCartList() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.cartlist);
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchCartList:',  response.data);
        return CartListModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching cartlist::',e);
      return null;
    }
  }

  @override
  Future<BannersModel?> fetchBanners() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.bannerslist);
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchBanners:',  response.data);
        return BannersModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching banners:',e);
      return null;
    }
  }

  @override
  Future<CategoryModel?> fetchCategories() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.categorieslist);
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchCategories:',  response.data);
        return CategoryModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching categories:',e);
      return null;
    }
  }

  @override
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng) async {
    try {
      Response response = await ApiClient.get('${PatientRemoteUrls.diagnosticCenterslist}?lat_long=${latlng}');
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchDiagnosticCenters:',  response.data);
        return DiognisticCenterModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching banners:', e);
      return null;
    }
  }

  @override
  Future<DiognisticDetailModel?> fetchDiagnosticDetails(id) async {
    try {
      Response response = await ApiClient.get("${PatientRemoteUrls.diagnosticDetail}/$id");
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchDiagnosticDetails:',  response.data);
        return DiognisticDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching diagnostic details:',e);
      return null;
    }
  }

  @override
  Future<TestModel?> fetchTest(latlang, catId,page) async {
    print('latlang::${latlang}');
    print('catId::${catId}');
    try {
      Response response = await ApiClient.get("${PatientRemoteUrls.test}?lat_long=${latlang}&category=${catId}&page=${page}");
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchTest:',  response.data);
        return TestModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching test data: ',e);
      return null;
    }
  }

  @override
  Future<ConditionBasedModel?> fetchConditionBased() async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.conditionBased}');
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchConditionBased:',  response.data);
        return ConditionBasedModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching ConditionBased data: $e");
      LogHelper.printLog('Error fetching ConditionBased data:',e);
      return null;
    }
  }

  @override
  Future<PatientsListModel?>fetchPatients() async {
    try {
      Response response =
      await ApiClient.get('${PatientRemoteUrls.patientslist}');
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchPatients:',  response.data);
        return PatientsListModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching fetchPatients data:',e);
      return null;
    }
  }

  @override
  Future<SuccessModel?>AddPatient(Map<String, dynamic> patientData) async {
    try {
      Response response = await ApiClient.post(PatientRemoteUrls.addPatient, data: patientData);
      if (response.statusCode == 200) {
        LogHelper.printLog('AddPatient:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error AddPatient data:', e);
      return null;
    }
  }

  @override
  Future<SuccessModel?>UpdatePatient(Map<String, dynamic> patientData,id) async {
    try {
      Response response = await ApiClient.put('${PatientRemoteUrls.updatePatient}');
      if (response.statusCode == 200) {
        LogHelper.printLog('UpdatePatient:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error UpdatePatient data:', e);
      return null;
    }
  }

  @override
  Future<SuccessModel?>DeletePatient(id) async {
    try {
      Response response = await ApiClient.delete('${PatientRemoteUrls.deletePatient}');
      if (response.statusCode == 200) {
        LogHelper.printLog('DeletePatient:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error DeletePatient data:',e);
      return null;
    }
  }
  @override
  Future<getPatientDetailModel?>GetPatientDetails(id) async {
    try {
      Response response = await ApiClient.get('${PatientRemoteUrls.pateint_details}/${id}');
      if (response.statusCode == 200) {
        LogHelper.printLog('GetPatientDetails:', response.data);
        return getPatientDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error GetPatientDetails data:',e);
      return null;
    }
  }


}
