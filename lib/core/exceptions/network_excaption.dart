import 'package:current_weather/core/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  const NetworkException();
}

class NetworkTimeOutException extends NetworkException {
  const NetworkTimeOutException();
}
