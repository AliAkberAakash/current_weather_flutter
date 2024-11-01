import 'package:current_weather/core/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  const NetworkException();
}

class NetworkTimeoutException extends NetworkException {
  const NetworkTimeoutException();
}
