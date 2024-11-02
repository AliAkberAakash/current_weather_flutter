import 'package:equatable/equatable.dart';

class NetworkRequest extends Equatable {
  final String url;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? headers;

  const NetworkRequest({
    required this.url,
    this.requestBody,
    this.queryParams,
    this.headers,
  });

  @override
  List<Object?> get props => [
        url,
        requestBody,
        queryParams,
        headers,
      ];
}
