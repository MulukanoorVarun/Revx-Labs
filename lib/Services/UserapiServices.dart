import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Models/CategoryModel.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Models/DiognisticCenterModel.dart';
import 'ApiClient.dart';

class UserApi {
  static Future<Response> registerPatient(
    String fullname,
    String phoneNumber,
    String email,
    String password,
    String gender,
    String dob,
    String age,
    String bloodGroup,
  ) async {
    try {
      // Create FormData object
      FormData formData = FormData.fromMap({
        'full_name': fullname,
        'email': email,
        'password': password,
        'mobile': phoneNumber,
        'gender': gender,
        'date_of_birth': dob,
        'age': age,
        'blood_group': bloodGroup,
      });

      Response response = await ApiClient.post(
        'auth/patient-register',
        data: formData,
      );

      return response;
    } catch (e) {
      print('Error registering patient: $e');
      rethrow;
    }
  }

  static Future<Response> loginapi(String email, String pw) async {
    try {
      Map<String, String> data = {"email": email, "password": pw};

      Response response = await ApiClient.post('auth/login', data: data);

      return response;
    } catch (e) {
      print('Error registering patient: $e');
      rethrow;
    }
  }

  static Future<CategoryModel?> categoryapi() async {
    try {
      print('categoryapi calling');
      Response response = await ApiClient.get('api/categories');
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        print('categoryapi :${jsonResponse}');
        return CategoryModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<BannersModel?> banners() async {
    try {
      Response response = await ApiClient.get('api/banners');
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        print('banners :${jsonResponse}');
        return BannersModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<DiognisticCenterModel?> diognosticCenter() async {
    try {
      Response response = await ApiClient.get('api/diagnostic-centres');
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        print('diognosticCenter :${jsonResponse}');
        return DiognisticCenterModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<DiognisticCenterDetailModel?> diognosticCenterDetails() async {
    try {
      Response response = await ApiClient.get('api/diagnostic-centre-detail');
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        print('diognosticCenterDetails :${jsonResponse}');
        return DiognisticCenterDetailModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
