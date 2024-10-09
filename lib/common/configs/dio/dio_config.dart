import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/app_utils.dart';

@lazySingleton
class DioApiClient {
  static const Duration _defaultTimeout = Duration(seconds: 60);
  static final BaseOptions defaultOptions = BaseOptions(
    connectTimeout: _defaultTimeout,
    sendTimeout: _defaultTimeout,
    receiveTimeout: _defaultTimeout,
    responseType: ResponseType.json,
    contentType: ContentType.json.value,
  );

  Dio _dio = Dio();

  static final Map<BaseOptions, DioApiClient> _instanceMap = {};

  factory DioApiClient({BaseOptions? options}) {
    options ??= defaultOptions;
    if (_instanceMap.containsKey(options)) {
      return _instanceMap[options] ?? DioApiClient();
    }
    final DioApiClient apiClient = DioApiClient._create(options: options);
    _instanceMap[options] = apiClient;
    return apiClient;
  }

  DioApiClient._create({BaseOptions? options}) {
    options ??= defaultOptions;
    _dio = Dio(options);
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  static DioApiClient get instance => DioApiClient();

  Future<void> post({
    String? url,
    Map<String, dynamic>? formData,
    String? token,
  }) async {
    try {
      final result = await _dio.post(
        url!,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      logger(result.data);
    } catch (e) {
      logger(e);
    }
  }
}
