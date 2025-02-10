import 'package:dio/dio.dart';
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
        '/auth/patient-register',
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

      Response response = await ApiClient.post('/auth/login', data: data);
      return response;
    } catch (e) {
      print('Error registering patient: $e');
      rethrow;
    }
  }
}
