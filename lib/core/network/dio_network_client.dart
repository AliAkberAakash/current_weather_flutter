import 'package:current_weather/core/exceptions/base_exception.dart';
import 'package:current_weather/core/exceptions/network_exceptions.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/core/network/network_response.dart';
import 'package:dio/dio.dart';

class DioNetworkClient implements NetworkClient {
  static const int _networkTimeoutDurationSeconds = 10;

  final Dio _dio;
  final List<Interceptor> interceptors;

  DioNetworkClient(
    this._dio, {
    this.interceptors = const [],
  }) {
    if (interceptors.isNotEmpty == true) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  @override
  Future<NetworkResponse> get(NetworkRequest request) async {
    try {
      final response = await _dio.get(
        request.url,
        options: _createDioOptions(request),
        queryParameters: request.queryParams,
      );
      return _handleResponse(response);
    } on DioException catch (error) {
      throw _handleDioExceptions(error);
    } on ServerException {
      rethrow;
    } catch (error) {
      throw const NetworkException();
    }
  }

  Options _createDioOptions(NetworkRequest request) => Options(
        contentType: request.headers?['Content-Type'] ?? 'application/json',
        responseType: ResponseType.json,
        sendTimeout: const Duration(seconds: _networkTimeoutDurationSeconds),
        receiveTimeout: const Duration(seconds: _networkTimeoutDurationSeconds),
        headers: request.headers ?? {},
      );

  NetworkResponse _handleResponse(Response<dynamic> response) {
    if (_isInvalidStatusCode(response.statusCode)) {
      throw ServerException(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    }

    return NetworkResponse(
      body: response.data,
      headers: response.headers.map,
    );
  }

  bool _isInvalidStatusCode(int? statusCode) {
    return statusCode == null || statusCode < 200 || statusCode >= 300;
  }

  BaseException _handleDioExceptions(DioException error) {
    if (error.response != null) {
      throw ServerException(
        statusCode: error.response?.statusCode,
        statusMessage: error.response?.statusMessage,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const NetworkTimeoutException();
      default:
        throw const NetworkException();
    }
  }
}
