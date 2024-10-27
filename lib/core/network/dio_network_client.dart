import 'package:current_weather/core/exceptions/network_excaption.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/core/network/network_response.dart';
import 'package:dio/dio.dart';

class DioNetworkClient implements NetworkClient {
  final Dio _dio;
  final List<Interceptor>? interceptors;

  DioNetworkClient(this._dio, {this.interceptors}) {
    if (interceptors?.isNotEmpty == true) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  @override
  Future<NetworkResponse> get(NetworkRequest request) async {
    // todo: add options, headers etc
    try {
      final response = await _dio.get(
        request.url,
      );

      return _handleResponse(response);
    } on DioException catch (error) {
      return _handleErrorResponse(error);
    }
  }

  NetworkResponse _handleResponse(Response<dynamic> response) {
    if (_isInvalidStatusCode(response.statusCode)) {
      throw const ServerException();
    }

    return NetworkResponse(
      body: response.data,
      headers: response.headers.map,
    );
  }

  bool _isInvalidStatusCode(int? statusCode) {
    return !(statusCode != null && statusCode >= 200 && statusCode < 300);
  }

  NetworkResponse _handleErrorResponse(DioException error) {
    if (error.response == null) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const NetworkTimeOutException();
        default:
          throw const NetworkException();
      }
    }

    return _handleResponse(error.response!);
  }
}
