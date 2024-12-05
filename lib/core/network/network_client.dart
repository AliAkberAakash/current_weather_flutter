import 'package:current_weather/core/network/network_request.dart';

import 'network_response.dart';

abstract class NetworkClient<T> {
  Future<NetworkResponse> get(final NetworkRequest request);
}
