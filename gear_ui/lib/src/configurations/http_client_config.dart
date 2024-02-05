class HttpClientConfig {
  HttpClientConfig({
    required this.baseUrl,
    this.endpoints = const <String, String>{},
  });

  final String baseUrl;
  final Map<String, String> endpoints;
}
