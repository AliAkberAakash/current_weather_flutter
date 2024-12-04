import 'package:current_weather/features/common/domain/error/error.dart';

abstract class ErrorMessageMapper {
  String mapErrorToMessage(BaseError error);
}

class ErrorMessageMapperImpl extends ErrorMessageMapper {
  @override
  String mapErrorToMessage(BaseError error) {
    switch (error.runtimeType) {
      case NetworkError _:
        return "Failed to load data";
      case NetworkTimeoutError _:
        return "Please check your internet connection";
      case ServerError _:
        return "Server Error";
      case CommonError _:
        return "Something went wrong";
      default:
        return "Something went wrong";
    }
  }
}
