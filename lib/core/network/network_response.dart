class NetworkResponse {
  final Map<String, dynamic> body;
  final Map<String, List<String>> headers;

  NetworkResponse({required this.body, required this.headers});
}