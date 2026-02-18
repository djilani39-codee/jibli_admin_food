/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $IosGen {
  const $IosGen();

  /// Directory path: ios/Runner
  $IosRunnerGen get runner => const $IosRunnerGen();
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/empty_data.svg
  String get emptyData => 'assets/icons/empty_data.svg';

  /// File path: assets/icons/order_confirm.svg
  String get orderConfirm => 'assets/icons/order_confirm.svg';

  /// File path: assets/icons/order_confirmed.svg
  String get orderConfirmed => 'assets/icons/order_confirmed.svg';

  /// File path: assets/icons/order_delivered.svg
  String get orderDelivered => 'assets/icons/order_delivered.svg';

  /// List of all assets
  List<String> get values =>
      [emptyData, orderConfirm, orderConfirmed, orderDelivered];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/logo_jibli.jpeg
  AssetGenImage get logoJibli =>
      const AssetGenImage('assets/logo/logo_jibli.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [logoJibli];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $IosRunnerGen {
  const $IosRunnerGen();

  /// File path: ios/Runner/GoogleService-Info.plist
  String get googleServiceInfo => 'ios/Runner/GoogleService-Info.plist';

  /// File path: ios/Runner/alarm.caf
  String get alarm => 'ios/Runner/alarm.caf';

  /// List of all assets
  List<String> get values => [googleServiceInfo, alarm];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const String sound1 = 'assets/sound1.mp3';
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
  static const $IosGen ios = $IosGen();

  /// List of all assets
  static List<String> get values => [sound1];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
