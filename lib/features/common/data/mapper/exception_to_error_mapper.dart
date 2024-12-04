import 'package:current_weather/core/exceptions/base_exception.dart';
import 'package:current_weather/core/exceptions/network_exceptions.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/features/common/domain/error/error.dart';

abstract class ExceptionToErrorMapper {
  BaseError mapExceptionToError(final BaseException exception);
}

class ExceptionToErrorMapperImpl extends ExceptionToErrorMapper {
  @override
  BaseError mapExceptionToError(final BaseException exception) {
    switch (exception.runtimeType) {
      case const (ServerException):
        exception as ServerException;
        return ServerError(
            statusCode: exception.statusCode,
            statusMessage: exception.statusMessage);
      case const (NetworkException):
        return NetworkError();
      case const (NetworkTimeoutException):
        return NetworkTimeoutError();
      default:
        return CommonError();
    }
  }
}
