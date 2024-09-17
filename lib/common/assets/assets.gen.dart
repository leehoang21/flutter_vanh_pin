/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsI18nGen {
  const $AssetsI18nGen();

  /// File path: assets/i18n/en.json
  String get en => 'assets/i18n/en.json';

  /// File path: assets/i18n/vi.json
  String get vi => 'assets/i18n/vi.json';

  /// List of all assets
  List<String> get values => [en, vi];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/aboutme.png
  AssetGenImage get aboutme => const AssetGenImage('assets/icons/aboutme.png');

  /// File path: assets/icons/add-circle.svg
  SvgGenImage get addCircle => const SvgGenImage('assets/icons/add-circle.svg');

  /// File path: assets/icons/avata_default.png
  AssetGenImage get avataDefault =>
      const AssetGenImage('assets/icons/avata_default.png');

  /// File path: assets/icons/biometrics.svg
  SvgGenImage get biometrics =>
      const SvgGenImage('assets/icons/biometrics.svg');

  /// File path: assets/icons/bottom_bar_goal.svg
  SvgGenImage get bottomBarGoal =>
      const SvgGenImage('assets/icons/bottom_bar_goal.svg');

  /// File path: assets/icons/categories.png
  AssetGenImage get categories =>
      const AssetGenImage('assets/icons/categories.png');

  /// File path: assets/icons/check.svg
  SvgGenImage get check => const SvgGenImage('assets/icons/check.svg');

  /// File path: assets/icons/clock.svg
  SvgGenImage get clock => const SvgGenImage('assets/icons/clock.svg');

  /// File path: assets/icons/filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/icons/filter.svg');

  /// File path: assets/icons/groups.svg
  SvgGenImage get groups => const SvgGenImage('assets/icons/groups.svg');

  /// File path: assets/icons/help.svg
  SvgGenImage get help => const SvgGenImage('assets/icons/help.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/ic_apple.svg
  SvgGenImage get icApple => const SvgGenImage('assets/icons/ic_apple.svg');

  /// File path: assets/icons/ic_facebook.svg
  SvgGenImage get icFacebook =>
      const SvgGenImage('assets/icons/ic_facebook.svg');

  /// File path: assets/icons/ic_google.svg
  SvgGenImage get icGoogle => const SvgGenImage('assets/icons/ic_google.svg');

  /// File path: assets/icons/ic_money.svg
  SvgGenImage get icMoney => const SvgGenImage('assets/icons/ic_money.svg');

  /// File path: assets/icons/ic_wallet.svg
  SvgGenImage get icWallet => const SvgGenImage('assets/icons/ic_wallet.svg');

  /// File path: assets/icons/icons8-debt-96.svg
  SvgGenImage get icons8Debt96 =>
      const SvgGenImage('assets/icons/icons8-debt-96.svg');

  /// File path: assets/icons/icons8-test-account-90.svg
  SvgGenImage get icons8TestAccount90 =>
      const SvgGenImage('assets/icons/icons8-test-account-90.svg');

  /// File path: assets/icons/language.png
  AssetGenImage get language =>
      const AssetGenImage('assets/icons/language.png');

  /// File path: assets/icons/log-in.svg
  SvgGenImage get logIn => const SvgGenImage('assets/icons/log-in.svg');

  /// File path: assets/icons/logout.png
  AssetGenImage get logout => const AssetGenImage('assets/icons/logout.png');

  /// File path: assets/icons/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/icons/notification.svg');

  /// File path: assets/icons/password.svg
  SvgGenImage get password => const SvgGenImage('assets/icons/password.svg');

  /// File path: assets/icons/rateme.png
  AssetGenImage get rateme => const AssetGenImage('assets/icons/rateme.png');

  /// File path: assets/icons/snackbar_failed.svg
  SvgGenImage get snackbarFailed =>
      const SvgGenImage('assets/icons/snackbar_failed.svg');

  /// File path: assets/icons/success.svg
  SvgGenImage get success => const SvgGenImage('assets/icons/success.svg');

  /// List of all assets
  List<dynamic> get values => [
        aboutme,
        addCircle,
        avataDefault,
        biometrics,
        bottomBarGoal,
        categories,
        check,
        clock,
        filter,
        groups,
        help,
        home,
        icApple,
        icFacebook,
        icGoogle,
        icMoney,
        icWallet,
        icons8Debt96,
        icons8TestAccount90,
        language,
        logIn,
        logout,
        notification,
        password,
        rateme,
        snackbarFailed,
        success
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/black_camera.png
  AssetGenImage get blackCamera =>
      const AssetGenImage('assets/images/black_camera.png');

  /// File path: assets/images/bottom_bar_my_page.png
  AssetGenImage get bottomBarMyPage =>
      const AssetGenImage('assets/images/bottom_bar_my_page.png');

  /// File path: assets/images/color_camera.png
  AssetGenImage get colorCamera =>
      const AssetGenImage('assets/images/color_camera.png');

  /// File path: assets/images/default_avatar.png
  AssetGenImage get defaultAvatar =>
      const AssetGenImage('assets/images/default_avatar.png');

  /// File path: assets/images/logo_splash.png
  AssetGenImage get logoSplash =>
      const AssetGenImage('assets/images/logo_splash.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [blackCamera, bottomBarMyPage, colorCamera, defaultAvatar, logoSplash];
}

class Assets {
  Assets._();

  static const $AssetsI18nGen i18n = $AssetsI18nGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
