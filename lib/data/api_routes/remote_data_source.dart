import 'package:dio/dio.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Models/ConditionBasedModel.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/data/api_routes/patient_remote_url.dart';

import '../../Models/CategoryModel.dart';
import '../../Models/DiognisticCenterModel.dart';
import '../../Models/PatientsListModel.dart';
import '../../Models/SuccessModel.dart';

abstract class RemoteDataSource {
  Future<CategoryModel?> fetchCategories();
  Future<BannersModel?> fetchBanners();
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng);
  Future<DiognisticDetailModel?> fetchDiagnosticDetails(id);
  Future<TestModel?> fetchTest(latlang, catId);
  Future<ConditionBasedModel?> fetchConditionBased();
  Future<PatientsListModel?> fetchPatients();
  Future<SuccessModel?> AddPatient(Map<String, dynamic> patientData);
  Future<SuccessModel?> UpdatePatient(Map<String, dynamic> patientData,id);
  Future<SuccessModel?> DeletePatient(id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<CategoryModel?> fetchCategories() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.categorieslist);
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching categories: $e");
      return null;
    }
  }

  @override
  Future<BannersModel?> fetchBanners() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.bannerslist);
      if (response.statusCode == 200) {
        return BannersModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching banners: $e");
      return null;
    }
  }

  @override
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng) async {
    try {
      Response response = await ApiClient.get(
          '${PatientRemoteUrls.diagnosticCenterslist}?lat_long=${latlng}');
      if (response.statusCode == 200) {
        return DiognisticCenterModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching banners: $e");
      return null;
    }
  }

  @override
  Future<DiognisticDetailModel?> fetchDiagnosticDetails(id) async {
    try {
      Response response =
          await ApiClient.get("${PatientRemoteUrls.diagnosticDetail}/$id");
      if (response.statusCode == 200) {
        return DiognisticDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching diagnostic details: $e");
      return null;
    }
  }

  @override
  Future<TestModel?> fetchTest(latlang, catId) async {
    print('latlang::${latlang}');
    print('catId::${catId}');
    try {
      Response response = await ApiClient.get(
          "${PatientRemoteUrls.test}?lat_long=${latlang}&category=${catId}");
      if (response.statusCode == 200) {
        print('fetchTest:${response.data}');
        return TestModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching test data: $e");
      return null;
    }
  }

  Future<ConditionBasedModel?> fetchConditionBased() async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.conditionBased}');
      if (response.statusCode == 200) {
        print('fetchConditionBased:${response.data}');
        return ConditionBasedModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching ConditionBased data: $e");
      return null;
    }
  }

  Future<PatientsListModel?>fetchPatients() async {
    try {
      Response response =
      await ApiClient.get('${PatientRemoteUrls.patientslist}');
      if (response.statusCode == 200) {
        print('fetchPatients:${response.data}');
        return PatientsListModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching fetchPatients data: $e");
      return null;
    }
  }

  Future<SuccessModel?>AddPatient(Map<String, dynamic> patientData) async {
    try {
      Response response = await ApiClient.post(PatientRemoteUrls.addPatient, data: patientData);
      if (response.statusCode == 200) {
        print('AddPatient:${response.data}');
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error AddPatient data: $e");
      return null;
    }
  }


  Future<SuccessModel?>UpdatePatient(Map<String, dynamic> patientData,id) async {
    try {
      Response response = await ApiClient.put('${PatientRemoteUrls.updatePatient}');
      if (response.statusCode == 200) {
        print('UpdatePatient:${response.data}');
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error UpdatePatient data: $e");
      return null;
    }
  }

  Future<SuccessModel?>DeletePatient(id) async {
    try {
      Response response = await ApiClient.delete('${PatientRemoteUrls.deletePatient}');
      if (response.statusCode == 200) {
        print('DeletePatient:${response.data}');
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error DeletePatient data: $e");
      return null;
    }
  }

}
