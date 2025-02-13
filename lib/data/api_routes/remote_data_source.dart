import 'package:dio/dio.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/data/api_routes/patient_remote_url.dart';

import '../../Models/CategoryModel.dart';
import '../../Models/DiognisticCenterModel.dart';

abstract class RemoteDataSource {
  Future<CategoryModel?> fetchCategories();
  Future<BannersModel?> fetchBanners();
  Future<DiognisticCenterModel?> fetchDiagnosticCenters();
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
  Future<DiognisticCenterModel?> fetchDiagnosticCenters() async {
    try {
      Response response = await ApiClient.get(PatientRemoteUrls.diagnosticCenterslist);
      if (response.statusCode == 200) {
        return DiognisticCenterModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error fetching banners: $e");
      return null;
    }
  }
}
