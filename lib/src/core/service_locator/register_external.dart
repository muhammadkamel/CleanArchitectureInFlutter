import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:oth_app/di_container.dart';
import 'package:oth_app/src/core/core.dart';

void registerExternal() {
  getIt.registerSingleton<BaseApiConsumer>(
    DioClientImpl(
      options: BaseOptions(
        baseUrl: Endpoints.baseUrl,
      ),
      dio: Dio(),
    ),
  );
  getIt.registerSingleton<InternetChecker>(
    InternetCheckerImpl(
      internetConnection: InternetConnection(),
    ),
  );
}
