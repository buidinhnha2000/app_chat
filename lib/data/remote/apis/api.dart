import 'dart:async';

import 'package:dio/dio.dart';

import '../../../common/either.dart';
import '../../../common/error.dart';
import '../dio.dart';
import '../status_code.dart';

abstract class Api {
  final Dio dio;

  const Api(this.dio);

  Future<Either<DataSourceError, T>> withTimeoutRequest<T>(
      Future<T> Function() request) async {
    try {
      return await Either.tryCatch(
        (err) => mapErrorToNetworkError(err),
        () async => await request(),
      ).timeout(const Duration(milliseconds: DioClient.connectTimeout));
    } on TimeoutException {
      return Left<DataSourceError, T>(const DataSourceError.timeout());
    }
  }

  DataSourceError mapErrorToNetworkError(Object? error) {
    if (error is DioError) {
      final code = error.response?.statusCode;
      if (code == null) return const DataSourceError.unknown();

      switch (code) {
        case NetworkStatusCode.notFound:
          return const DataSourceError.notFound();
        case NetworkStatusCode.badRequest:
          return const DataSourceError.badRequest();
        case NetworkStatusCode.forbidden:
          return const DataSourceError.forbidden();
        case NetworkStatusCode.internalServerError:
          return const DataSourceError.internalServerError();
        case NetworkStatusCode.unauthorized:
          return const DataSourceError.unauthorized();
        default:
          return const DataSourceError.unknown();
      }
    } else if (error is TimeoutException) {
      return const DataSourceError.timeout();
    }

    // TODO: Add more exception
    return const DataSourceError.unknown();
  }
}
