import 'package:dio/dio.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement authentication interceptor
    handler.next(options);
  }
}
