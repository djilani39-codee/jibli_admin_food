import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_remote_data_source.g.dart';

/// Minimal ParseErrorLogger used by generated Retrofit code.
abstract class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions request);
}

@RestApi(
  baseUrl: "https://kazachange.alphadev39.com/api/v1",
  parser: Parser.FlutterCompute,
)
abstract class ProfileRemoteDataSource {
  factory ProfileRemoteDataSource(Dio dio, {String baseUrl}) =
      _ProfileRemoteDataSource;

  @POST("/profile/update-avatar")
  Future<HttpResponse> updateAvatar({@Body() required FormData request});
  @POST("/profile/update-email")
  Future<HttpResponse> updateEmail({@Body() required FormData request});
  @POST("/profile/update-phone")
  Future<HttpResponse> updatePhone({@Body() required FormData request});
  @POST("/auth/change-password")
  Future<HttpResponse> changePassword(
      {@Body() required Map<String, String> request});
  @POST("/profile/delete-account")
  Future<HttpResponse> deleteAccount();
}
