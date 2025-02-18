import 'package:dio/dio.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Models/ConditionBasedModel.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/data/api_routes/patient_remote_url.dart';

import '../../Models/CategoryModel.dart';
import '../../Models/DiognisticCenterModel.dart';

abstract class RemoteDataSource {
  Future<CategoryModel?> fetchCategories();
  Future<BannersModel?> fetchBanners();
  Future<DiognisticCenterModel?> fetchDiagnosticCenters(latlng);
  Future<DiognisticDetailModel?> fetchDiagnosticDetails(id);
  Future<TestModel?> fetchTest(latlang, catId);
  Future<ConditionBasedModel?>fetchConditionBased();
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
}
