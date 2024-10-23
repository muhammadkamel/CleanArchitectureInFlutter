import 'package:dio/dio.dart';
import 'package:oth_app/src/core/network/dio/dio.dart';

class DioClientImpl extends BaseApiConsumer {
  final Dio _dio;
  final BaseOptions _options;
  final List<Interceptor> _interceptors;
  final Function(DioException exception)? _exceptionHandler;

  DioClientImpl({
    required BaseOptions options,
    required Dio dio,
    List<Interceptor> interceptors = const [],
    Function(DioException exception)? exceptionHandler,
  })  : _interceptors = interceptors,
        _options = options,
        _exceptionHandler = exceptionHandler,
        _dio = dio {
    _dio.options = _options;

    for (final interceptor in _interceptors) {
      _dio.interceptors.add(interceptor);
    }
  }

  @override
  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (exception) {
      if (_exceptionHandler == null) {
        rethrow;
      } else {
        throw _exceptionHandler(exception);
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response<dynamic> response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (exception) {
      if (_exceptionHandler == null) {
        rethrow;
      } else {
        throw _exceptionHandler(exception);
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (exception) {
      if (_exceptionHandler == null) {
        rethrow;
      } else {
        throw _exceptionHandler(exception);
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (exception) {
      if (_exceptionHandler == null) {
        rethrow;
      } else {
        throw _exceptionHandler(exception);
      }
    } catch (exception) {
      rethrow;
    }
  }
}
