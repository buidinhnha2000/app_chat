import 'package:dio/dio.dart';

import 'interceptors/authentication_interceptor.dart';

class DioClient {
  final String baseUrl;

  DioClient({required this.baseUrl}) {
    final baseOptions = createBaseOptions();
    authDio = Dio(baseOptions)..interceptors.add(AuthenticationInterceptor());
    dio = Dio(baseOptions);
  }

  BaseOptions createBaseOptions() {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  late final Dio authDio;
  late final Dio dio;

  static const connectTimeout = 30000;
  static const receiveTimeout = 30000;
  static const sendTimeout = 30000;
}
