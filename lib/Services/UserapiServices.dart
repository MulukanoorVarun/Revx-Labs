import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:revxpharma/Models/CategoryModel.dart';
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
      print("response:${response}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.data);
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
}
