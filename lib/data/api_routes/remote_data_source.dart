import 'package:dio/dio.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/data/api_routes/patient_remote_url.dart';

import '../../Models/CategoryModel.dart';

abstract class RemoteDataSource {
  Future<CategoryModel?> fetchCategories();
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
}
