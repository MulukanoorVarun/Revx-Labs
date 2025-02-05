// import 'package:dio/dio.dart';
//
// class DioClient {
//   static final Dio _dio = Dio(
//       BaseOptions(
//         baseUrl: "https://api.example.com",
//         connectTimeout: const Duration(seconds: 10),
//         receiveTimeout: const Duration(seconds: 10),
//       ));
//
//   static void setupInterceptors() {
//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final accessToken = await AuthService.getAccessToken();
//         if (accessToken != null) {
//           options.headers["Authorization"] = "Bearer $accessToken";
//         }
//         return handler.next(options);
//       },
//       onError: (DioException e, handler) async {
//         if (e.response?.statusCode == 401) {
//           bool refreshed = await _refreshToken();
//           if (refreshed) {
//             final newAccessToken = await AuthService.getAccessToken();
//             e.requestOptions.headers["Authorization"] =
//             "Bearer $newAccessToken";
//             try {
//               final retryResponse = await _dio.fetch(e.requestOptions);
//               return handler.resolve(retryResponse);
//             } catch (retryError) {
//               return handler.reject(retryError);
//             }
//           }
//         }
//         return handler.next(e);
//       },
//     ));
//   }
// }