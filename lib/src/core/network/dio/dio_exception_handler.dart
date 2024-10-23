import 'package:dio/dio.dart';

String networkExceptionHandler(DioException exception) {
  final String? errorDescription = exception.response?.data['errorDescription'];
  final String message = errorDescription ??
      exception.response?.statusMessage ??
      "Something went wrong, please try again later";

  return message;
}
