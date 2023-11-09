import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

@freezed
class DataSourceError with _$DataSourceError {
  // Network
  const factory DataSourceError.notFound() = NotFound;
  const factory DataSourceError.internalServerError() = InternalServerError;
  const factory DataSourceError.unauthorized() = Unauthorized;
  const factory DataSourceError.badRequest() = BadRequest;
  const factory DataSourceError.timeout() = Timeout;
  const factory DataSourceError.forbidden() = Forbidden;

  // Database

  const factory DataSourceError.unknown() = Unknown;
}
