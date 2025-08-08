import 'package:dio/dio.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/apis/apis_url.dart';
import 'package:tcw/core/constansts/string_extensions.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

class ApiService {
  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => status! < 500,
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.i('--> ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.i('<-- ${response.statusCode} ${response.requestOptions.uri}');
        logger.i('Response: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        logger.e('Error [${e.response?.statusCode}] => ${e.message}');
        return handler.next(e);
      },
    ));
  }
  factory ApiService() => instance;
  static final ApiService instance = ApiService._internal();
  late final Dio _dio;
  Future<ApiResponse<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool withToken = true,
  }) async {
    final Map<String, String> header = {
      ...?headers,
      if (withToken) 'Authorization': 'Bearer ${userData?.token}',
    };
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: header),
      );
      final Map responseData = response.data is Map ? response.data : {};
      return ApiResponse<dynamic>(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        mapData: response.data,
        message: responseData['message'],
        lastPage: responseData['data']?['last_page']?.toString().toIntOrNull,
        limit: responseData['data']?['limit']?.toString().toIntOrNull,
        offset: responseData['data']?['offset']?.toString().toIntOrNull,
        total: responseData['data']?['total']?.toString().toIntOrNull,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ApiResponse<dynamic>> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
        bool withToken = true,
      }) async {
    final Map<String, String> header = {
      ...?headers,
      if (withToken) 'Authorization': 'Bearer ${userData?.token}',
    };
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: header),
      );

      // Ensure type safety for the response data
      final responseData = response.data is Map
          ? Map<String, dynamic>.from(response.data as Map)
          : <String, dynamic>{};

      return ApiResponse<dynamic>(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        mapData: responseData,
        message: responseData['message']?.toString(),
        lastPage: responseData['data'] is Map ? responseData['data']['last_page']?.toString().toIntOrNull : null,
        limit: responseData['data'] is Map ? responseData['data']['limit']?.toString().toIntOrNull : null,
        offset: responseData['data'] is Map ? responseData['data']['offset']?.toString().toIntOrNull : null,
        total: responseData['data'] is Map ? responseData['data']['total']?.toString().toIntOrNull : null,
      );
    } on DioException catch (e) {
      logger.e('''
      path : $path
      response : ${e.response?.data},
      errorMessages : ${e.response?.statusMessage}
      statusCode : ${e.response?.statusCode}
      responseData : ${e.response?.data}
      error : ${userData?.token}
      ''');
      throw _handleDioError(e);
    }
  }

  Future<ApiResponse<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, String>? headers,
    bool withToken = true,
  }) async {
    final Map<String, String> header = {
      ...?headers,
      if (withToken) 'Authorization': 'Bearer ${userData?.token}',
    };
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(headers: header),
      );
      logger.d('''
        path : $path
        data : ${data is FormData ? data.fields : data}
        response : ${response.data},
        statusCode : ${response.statusCode}
        ''');
      final Map responseData = response.data is Map ? response.data : {};
      String errorMessages = '';
      if (responseData['errors'] is Map) {
        final errors = responseData['errors'];
        (errors as Map).forEach((key, value) {
          if (value is List) {
            for (var element in value) {
              errorMessages += '$element\n';
            }
          } else {
            errorMessages += '$value\n';
          }
        });
      }

      return ApiResponse<dynamic>(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        mapData: response.data,
        message: responseData['message'] ?? errorMessages.trim(),
        lastPage: responseData['data']?['last_page'],
        limit: responseData['data']?['limit'],
        offset: responseData['data']?['offset'],
        total: responseData['data']?['total'],
      );
    } on DioException catch (e) {
      logger.e('''
        path : $path
        data : ${data is FormData ? data.fields : data}
        response : ${e.response?.data},
        errorMessages : ${e.response?.statusMessage}
        statusCode : ${e.response?.statusCode}
        responseData : ${e.response?.data}
        ''');
      return _handleDioError(e);
    }
  }

  ApiResponse<dynamic> _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode ?? 0;
    String message = 'Unexpected error';

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad SSL certificate.';
        break;
      case DioExceptionType.badResponse:
        message = 'Server error';
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection.';
        break;
      case DioExceptionType.unknown:
        message = e.message ?? 'Unknown error occurred.';
        break;
    }

    return ApiResponse<dynamic>(
      data: null,
      statusCode: statusCode,
      message: message,
      mapData: e.response?.data ?? {},
    );
  }
}
