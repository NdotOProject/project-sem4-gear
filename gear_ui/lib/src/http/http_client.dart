import 'dart:convert';
import 'dart:io';

// external packages
import 'package:dio/dio.dart';

class HttpClient {
  static late final HttpClient? _instance;

  final String baseUrl;
  final Map<String, String> endpoints;
  final Dio _dio;

  HttpClient._(
    this.baseUrl,
    this.endpoints,
  ) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            // contentType:
            // headers:
          ),
        );

  static Future<HttpClient> get instance async {
    if (_instance == null) {
      final file = File("./http_client_config.json");

      final String jsonString = await file.readAsString();

      final config = json.decode(jsonString) as Map<String, dynamic>;
      _instance = HttpClient._(
        config["baseUrl"] as String,
        {...config["endpoints"]},
      );
    }

    return _instance!;
  }

  Future<T> get<T>(
    Endpoint endpoint, {
    T Function(Response<String> response)? transformResponse,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final unCompletePath = endpoints[endpoint._name];
    assert(unCompletePath != null, "The endpoint does not exist.");

    final response = await _dio.get<String>(
      endpoint._path(unCompletePath!),
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return (transformResponse ?? (resp) => resp as T)(response);
  }
}

class Endpoint {
  static final RegExp _namedParamFormat = RegExp(r':[a-zA-Z0-9]+');

  final String _name;
  final Map<String, String>? _params;

  Endpoint(
    this._name, {
    Map<String, dynamic>? pathParameters,
  }) : _params = pathParameters?.map(
          (key, value) => MapEntry<String, String>(key, "$value"),
        );

  String _path(String path) {
    if (!path.contains(":") || _params == null || _params.isEmpty) {
      return path;
    } else {
      // get elements of path have parameter.
      final elements = path.split('/').where(
            (element) => element.contains(":"),
          );

      // find params and set to path.
      for (var element in elements) {
        _namedParamFormat.allMatches(element).forEach((e) {
          String? param = e.group(0);
          if (param != null) {
            String paramName = param.split(":").join();
            path = path.replaceFirst(
              param,
              _params[paramName] ?? param,
            );
          }
        });
      }

      return path;
    }
  }
}
