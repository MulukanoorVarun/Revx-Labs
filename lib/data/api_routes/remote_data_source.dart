import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revxpharma/Models/AppointmentDetailsModel.dart';
import 'package:revxpharma/Models/AppointmentsModel.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Models/CartListModel.dart';
import 'package:revxpharma/Models/ConditionBasedModel.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Models/ProfileDetailModel.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Models/getPatientDetailModel.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/data/api_routes/patient_remote_url.dart';

import '../../Components/debugPrint.dart';
import '../../Models/CategoryModel.dart';
import '../../Models/DiognisticCenterModel.dart';
import '../../Models/LoginModel.dart';
import '../../Models/PatientsListModel.dart';
import '../../Models/SuccessModel.dart';
import '../../Models/TestDetailsModel.dart';

abstract class RemoteDataSource {
  Future<LoginModel?> loginApi(Map<String, dynamic> data);
  Future<SuccessModel?> registerApi(Map<String, dynamic> data);
  Future<CategoryModel?> fetchCategories(String query);
  Future<BannersModel?> fetchBanners();
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng);
  Future<DiognisticDetailModel?> fetchDiagnosticDetails(id);
  Future<TestModel?> fetchTest(latlang, catId, search_Query, page, diagnosticID,scanId,x_rayId);
  Future<ConditionBasedModel?> fetchConditionBased();
  Future<PatientsListModel?> fetchPatients();
  Future<SuccessModel?> AddPatient(Map<String, dynamic> patientData);
  Future<SuccessModel?> UpdatePatient(Map<String, dynamic> patientData, id);
  Future<SuccessModel?> DeletePatient(id);
  Future<getPatientDetailModel?> GetPatientDetails(id);
  Future<getPatientDetailModel?> GetDefaultPatientDetails();
  Future<CartListModel?> fetchCartList();
  Future<SuccessModel?> AddToCart(Map<String, dynamic> Data);
  Future<SuccessModel?> updateCart(String id,int noOfPersons);
  Future<SuccessModel?> RemoveFromCart(id);
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> Data);
  Future<ProfileDetailModel?> getProfileDetails();
  Future<AppointmentsModel?> fetchAppointments();
  Future<AppointmentDetailsModel?> AppointmentDetails(id);
  Future<TestDetailsModel?> getTestDetailsApi(id);
}

class RemoteDataSourceImpl implements RemoteDataSource {

  @override
  Future<TestDetailsModel?> getTestDetailsApi(id) async {
    try {
      Response response = await ApiClient.get("${PatientRemoteUrls.test_details}/${id}");
      if (response.statusCode == 200) {
        debugPrint("${response.data}");
        return TestDetailsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      debugPrint("${e.toString()}");
      return null;
    }
  }

  @override
  Future<SuccessModel?> registerApi(Map<String, dynamic> data) async {
    try {
      Response response =
          await ApiClient.post("${PatientRemoteUrls.userRegister}", data: data);
      if (response.statusCode == 200) {
        LogHelper.printLog('registerApi:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error registerApi::', e);
      return null;
    }
  }

  @override
  Future<LoginModel?> loginApi(Map<String, dynamic> data) async {
    try {
      Response response = await ApiClient.post("${PatientRemoteUrls.userLogin}", data: data);
      if (response.statusCode == 200) {
        LogHelper.printLog('loginApi:', response.data);
        return LoginModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error loginApi::', e);
      return null;
    }
  }

  @override
  Future<AppointmentDetailsModel?> AppointmentDetails(id) async {
    try {
      Response response = await ApiClient.get(
          "${PatientRemoteUrls.appopintment_details}/${id}");
      if (response.statusCode == 200) {
        LogHelper.printLog('AppointmentDetails:', response.data);
        return AppointmentDetailsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error AppointmentDetails::', e);
      return null;
    }
  }

  @override
  Future<AppointmentsModel?> fetchAppointments() async {
    try {
      Response response =
          await ApiClient.get(PatientRemoteUrls.appopintment_list);
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchAppointments:', response.data);
        return AppointmentsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetchAppointments::', e);
      return null;
    }
  }

  @override
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> Data) async {
    try {
      Response response =
          await ApiClient.post(PatientRemoteUrls.book_appopintment, data: Data);
      if (response.statusCode == 200) {
        LogHelper.printLog('bookAppointment:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error bookAppointment::', e);
      return null;
    }
  }

  @override
  Future<SuccessModel?> RemoveFromCart(id) async {
    try {
      Response response =
          await ApiClient.delete("${PatientRemoteUrls.removeCart}/${id}");
      if (response.statusCode == 200) {
        LogHelper.printLog('RemoveFromCart:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error RemoveFromCart::', e);
      return null;
    }
  }


  @override
  Future<SuccessModel?> updateCart(String id,int noofPersons) async {
    try {
      Response response =
      await ApiClient.put("${PatientRemoteUrls.updateCart}/${id}?no_of_persons=${noofPersons}");
      if (response.statusCode == 200) {
        LogHelper.printLog('updateCart:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error updateCart::', e);
      return null;
    }
  }

  @override
  Future<SuccessModel?> AddToCart(Map<String, dynamic> Data) async {
    try {
      Response response =
          await ApiClient.post(PatientRemoteUrls.addToCart, data: Data);
      if (response.statusCode == 200) {
        LogHelper.printLog('AddToCart:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error Add to cart::', e);
      return null;
    }
  }

  @override
  Future<CartListModel?> fetchCartList() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.cartlist);
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchCartList:', response.data);
        return CartListModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching cartlist::', e);
      return null;
    }
  }

  @override
  Future<BannersModel?> fetchBanners() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.bannerslist);
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchBanners:', response.data);
        return BannersModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching banners:', e);
      return null;
    }
  }

  @override
  Future<CategoryModel?> fetchCategories(String query) async {
    try {
      Response response = await ApiClient.get("${PatientRemoteUrls.categorieslist}?search=$query");
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchCategories:', response.data);
        return CategoryModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching categories:', e);
      return null;
    }
  }

  @override
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng) async {
    try {
      Response response = await ApiClient.get(
          '${PatientRemoteUrls.diagnosticCenterslist}?lat_long=${latlng}');
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchDiagnosticCenters:', response.data);
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
      Response response =
          await ApiClient.get("${PatientRemoteUrls.diagnosticDetail}/$id");
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchDiagnosticDetails:', response.data);
        return DiognisticDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching diagnostic details:', e);
      return null;
    }
  }

  @override
  Future<TestModel?> fetchTest(
      latlang, catId, search_Query, page, diagnosticID,scanId,x_rayId) async {
    try {
      Response response = await ApiClient.get(
          "${PatientRemoteUrls.test}?${scanId}&${x_rayId}&lat_long=${latlang}&category=${catId}&search=${search_Query}&page=${page}&diagnostic_center=${diagnosticID}");
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchTest:', response.data);
        return TestModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching test data: ', e);
      return null;
    }
  }

  @override
  Future<ConditionBasedModel?> fetchConditionBased() async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.conditionBased}');
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchConditionBased:', response.data);
        return ConditionBasedModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching ConditionBased data: $e");
      LogHelper.printLog('Error fetching ConditionBased data:', e);
      return null;
    }
  }

  @override
  Future<PatientsListModel?> fetchPatients() async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.patientslist}');
      if (response.statusCode == 200) {
        LogHelper.printLog('fetchPatients:', response.data);
        return PatientsListModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error fetching fetchPatients data:', e);
      return null;
    }
  }

  @override
  Future<SuccessModel?> AddPatient(Map<String, dynamic> patientData) async {
    try {
      Response response =
          await ApiClient.post(PatientRemoteUrls.addPatient, data: patientData);
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
  Future<SuccessModel?> UpdatePatient(
      Map<String, dynamic> patientData, id) async {
    try {
      Response response = await ApiClient.put(
          '${PatientRemoteUrls.updatePatient}/${id}',
          data: patientData);
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
  Future<SuccessModel?> DeletePatient(id) async {
    try {
      Response response =
          await ApiClient.delete('${PatientRemoteUrls.deletePatient}/${id}');
      if (response.statusCode == 200) {
        LogHelper.printLog('DeletePatient:', response.data);
        return SuccessModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error DeletePatient data:', e);
      return null;
    }
  }

  @override
  Future<getPatientDetailModel?> GetPatientDetails(id) async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.pateint_details}/${id}');
      if (response.statusCode == 200) {
        LogHelper.printLog('GetPatientDetails:', response.data);
        return getPatientDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error GetPatientDetails data:', e);
      return null;
    }
  }

  @override
  Future<ProfileDetailModel?> getProfileDetails() async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.profile_details}');
      if (response.statusCode == 200) {
        LogHelper.printLog('getProifileDetails:', response.data);
        return ProfileDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error getProifileDetails data:', e);
      return null;
    }
  }

  @override
  Future<getPatientDetailModel?> GetDefaultPatientDetails() async {
    try {
      Response response =
          await ApiClient.get('${PatientRemoteUrls.default_pateint_details}');
      if (response.statusCode == 200) {
        LogHelper.printLog('GetPatientDetails:', response.data);
        return getPatientDetailModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      LogHelper.printLog('Error GetDefaultPatientDetails data:', e);
      return null;
    }
  }
}
