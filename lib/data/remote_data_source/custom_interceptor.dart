import 'package:dio/dio.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';

import '../../app/locator.dart';
import '../../core/extensions/string_extensions.dart';
import '../local_data_source/local_data_keys.dart';
import '../local_data_source/local_data_source.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final accessToken = sl<LocalDataSource>().getValue<String?>(
      LocalDataKeys.accessToken,
    );

    final marketId = sl<LocalDataSource>()
        .getValue<FastFoodEntity>(LocalDataKeys.user)
        ?.markets
        ?.first
        .marketId;
    final userId = sl<LocalDataSource>()
        .getValue<FastFoodEntity>(LocalDataKeys.user)
        ?.userId;
    final apiToken = sl<LocalDataSource>()
        .getValue<FastFoodEntity>(LocalDataKeys.user)
        ?.apiToken;

    // إضافة query parameters فقط للـ GET requests و requests أخرى بدون FormData
    if (options.method.toUpperCase() != 'POST' || options.data is! FormData) {
      options.queryParameters["market_id"] = marketId;
      options.queryParameters["user_id"] = userId;
      options.queryParameters["api_token"] = apiToken;
    }

    // إضافة /public للـ /markets/debt/ endpoints (العمولات)
    if (options.path.contains('/markets/debt/')) {
      options.baseUrl = 'https://foodwood.site/jibli/public/api';
    }

    'baseUrl : ${options.baseUrl}\n'
            'url : ${options.uri}\n'
            'path : ${options.path}\n'
            'data : ${options.data}\n'
            'queryParameters: ${options.queryParameters}\n'
            'accessToken : $accessToken\n'
        .log(name: 'Dio Request');
    // also print plainly so flutter run console shows it clearly
    print('Dio Request -> ${options.method} ${options.uri} | queries=${options.queryParameters}');
    if (accessToken == null) {
      'headers : ${options.headers}'.log(name: 'Dio Request');

      return super.onRequest(options, handler);
    } else {
      options.headers['Authorization'] = 'Bearer $accessToken';

      'headers : ${options.headers}'.log(name: 'Dio Request');
      return super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    'headers : ${response.headers}\n'
            'data : ${response.data}\n'
            'statusCode : ${response.statusCode}\n'
            'statusMessage : ${response.statusMessage}'
        .log(name: 'Dio Response');

    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    'error : ${err.error}\n'
            'message : ${err.message}\n'
            'response : ${err.response}\n'
            'data : ${err.response?.data}\n'
            'headers : ${err.response?.headers}\n'
            'statusCode : ${err.response?.statusCode}\n'
            'statusMessage : ${err.response?.statusMessage}'
        .log(name: 'Dio Error');

    return super.onError(err, handler);
  }
}
