// import 'package:dio/dio.dart';
// import 'package:hungry/core/utils/pref_helper.dart';
//
// class DioClient {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "https://sonic-zdi0.onrender.com/api",
//       headers: {"Content_Type": "application/json"},
//     ),
//   );
//
//   //we will send token here
//   DioClient() {
//     // here
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token = await PrefHelper.getToken();
//
//           if (token != null && token.isNotEmpty) {
//             // here we tell the dio about the type of token like bearer token and ......
//             //and if exist send it with request and if not just send the request without token
//             options.headers["Authorization"] = "Bearer$token";
//           }
//
//           handler.next(options);
//         },
//       ),
//     );
//   }
//
//   //get method for _dio bc its private
//   Dio get dio => _dio;
// }

import 'package:dio/dio.dart';
import 'package:hungry/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://sonic-zdi0.onrender.com/api",
      headers: {"Content_Type": "application/json"},
    ),
  );

  DioClient() {
    /// send token here
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          // here we tell the dio about the type of token like bearer token and ......
          //and if exist send it with request and if not just send the request without token

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }

  //get method for _dio bc its private
  Dio get dio => _dio;
}
