import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../extensions/string_extensions.dart';

part 'exceptions.freezed.dart';

extension ObjectExtension on Object {
  Exceptions get getException {
    switch (runtimeType) {
      case SocketException:
        return const Exceptions.network("there_is_no_internet_connection");
      case EmptyException:
        return Exceptions.empty(this);
      default:
        return Exceptions.other(this);
    }
  }
}

extension ExceptionHandeler on DioException {
  Exceptions handelException() {
    if (response?.statusCode! == 422) {
      return Exceptions.other(response?.data["message"]);
    }
    if (response?.statusCode! == 401) {
      return Exceptions.wrongCredentials(response?.data["message"]);
    }
    if (error != null) {
      switch (error.runtimeType) {
        case SocketException:
          return const Exceptions.network("لا يوجد اتصال بالإنترنت");
        default:
          return const Exceptions.other("حدث خطـأ ما");
      }
    } else {
      return const Exceptions.other("حدث خطـأ ما");
    }
  }
}

@freezed
// abstract class Exceptions with Exception, _$Exceptions {
class Exceptions with _$Exceptions implements Exception {
  const Exceptions._() : super();
  const factory Exceptions.network(String message) = NetworkException;
  const factory Exceptions.empty(dynamic data) = EmptyException;
  const factory Exceptions.other(dynamic data) = OtherException;
  const factory Exceptions.emailInvalude(dynamic data) = EmailInvalude;
  const factory Exceptions.passwordInvalude(dynamic data) = PasswordInvalude;
  const factory Exceptions.locationServiceNotEnabled(dynamic data) =
      LocationServiceNotEnabled;
  const factory Exceptions.invalidConfirmationCode(String data) =
      InvalidConfirmationCode;

  const factory Exceptions.wrongCredentials(dynamic data) =
      WrongCredentialsException;

  String get localizedErrorMessage {
    return when<String>(
      network: (message) {
        'Request error:'.log();
        return message;

        //return message'Network error';
      },
      locationServiceNotEnabled: (data) {
        'Unknown error: $data'.log();

        return data;
      },
      empty: (d) {
        'Null/Empty error: $d'.log();
        return d ?? 'No data!';
      },
      other: (o) {
        'Unknown error: $o'.log();

        return o;
      },
      emailInvalude: (e) {
        'Unknown error: $e'.log();

        return e;
      },
      passwordInvalude: (p) {
        'Unknown error: $p'.log();

        return p;
      },
      invalidConfirmationCode: (String data) {
        return data;
      },
      wrongCredentials: (data) {
        return "$data";
      },
    );
  }
}
