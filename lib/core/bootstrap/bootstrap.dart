import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../observers/bloc_observer.dart';

import 'package:easy_localization/easy_localization.dart';
//

void bootstrap(Widget app) {
  FlutterError.onError = (details) {
    developer.log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('ar'),
         // Locale('en')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: app),
  );
  (error, stackTrace) =>
      developer.log(error.toString(), stackTrace: stackTrace);
}
