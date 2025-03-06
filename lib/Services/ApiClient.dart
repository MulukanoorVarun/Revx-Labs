import 'dart:io';
import 'package:dio/dio.dart';
import '../data/api_routes/patient_remote_url.dart';
import 'AuthService.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${PatientRemoteUrls.baseUrl}",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        "Content-Type": "application/json"
      },
    ),
  );

  static void setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        bool isTokenExpired = await AuthService.isTokenExpired();
        if (isTokenExpired) {
          bool refreshed = await _refreshToken();
          if (!refreshed) {
            return handler.reject(DioException(requestOptions: options, message: "Token refresh failed"));
          }
        }
        final accessToken = await AuthService.getAccessToken();
        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response != null) {
          switch (e.response?.statusCode) {
            case 400:
              print("Bad Request: ${e.response?.data}");
              break;
            case 401:
              print("Unauthorized: Attempting token refresh...");
              bool refreshed = await _refreshToken();
              if (refreshed) {
                final newAccessToken = await AuthService.getAccessToken();
                e.requestOptions.headers["Authorization"] = "Bearer $newAccessToken";
                try {
                  final retryResponse = await _dio.fetch(e.requestOptions);
                  return handler.resolve(retryResponse);
                } catch (retryError) {
                  if (retryError is DioException) {
                    return handler.reject(retryError);
                  } else {
                    return handler.reject(DioException(
                      requestOptions: e.requestOptions,
                      error: retryError,
                      message: "Unknown error occurred while retrying request",
                    ));
                  }
                }
              }
              break;
            case 403:
              print("Forbidden: ${e.response?.data}");
              break;
            case 404:
              print("Not Found: ${e.response?.data}");
              break;
            case 500:
              print("Server Error: ${e.response?.data}");
              break;
          }
        } else {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.sendTimeout ||
              e.type == DioExceptionType.receiveTimeout) {
            print("Timeout Error: ${e.message}");
          } else if (e.error is SocketException) {
            print("No Internet Connection: ${e.error}");
          } else {
            print("Unexpected Error: ${e.message}");
          }
        }
        return handler.next(e);
      },
    ));
  }

  static Future<bool> _refreshToken() async {
    try {
      final newToken = await AuthService.refreshToken();
      if (newToken != null) {
        print("Token refreshed successfully");
        return true;
      }
    } catch (e) {
      print("Token refresh failed: $e");
    }
    return false;
  }

  static Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      print("called get method");
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }


  static Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Response _handleError(dynamic error) {
    if (error is DioException) {
      print("DioException occurred: ${error.message}");
      throw error;
    } else {
      print("Unexpected error: $error");
      throw Exception("Unexpected error occurred");
    }
  }
}
