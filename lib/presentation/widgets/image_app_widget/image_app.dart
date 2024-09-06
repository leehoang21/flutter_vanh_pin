// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/utils/app_utils.dart';

// ignore: must_be_immutable
class AppImageWidget extends StatelessWidget {
  final String? path;
  bool isRemote = false;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget? defultImage;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;

  AppImageWidget({
    Key? key,
    required this.path,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.color,
    this.defultImage,
  }) : super(key: key);

  Widget get _placeholder {
    late double size;
    if (width != null && height != null) {
      size = width! > height! ? height! : width!;
      size = size / 3;
    } else {
      size = 6;
    }
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget get _errorWidget {
    return Center(
      child: defultImage,
    );
  }

  Widget _buildFileImageWidget() {
    if (isRemote) {
      return CachedNetworkImage(
          imageUrl: path ?? '',
          fit: fit,
          width: width,
          filterQuality: FilterQuality.medium,
          fadeInDuration: const Duration(milliseconds: 100),
          fadeOutDuration: const Duration(milliseconds: 100),
          height: height,
          color: color,
          placeholder: (context, url) => placeholder ?? _placeholder,
          errorWidget: (context, url, error) => errorWidget ?? _errorWidget);
    }

    return image(FileImage(File(path!)));
  }

  Widget _buildSvgImageWidget() {
    if (isRemote) {
      return SvgPicture.network(
        path!,
        fit: fit,
        width: width,
        height: height,
        color: color,
        placeholderBuilder: (context) => placeholder ?? _placeholder,
      );
    }

    return SvgPicture.asset(
      path!,
      fit: fit,
      width: width,
      height: height,
      color: color,
      placeholderBuilder: (context) => placeholder ?? _placeholder,
    );
  }

  Widget _buildNormalImageWidget() {
    if (isRemote) {
      return image(NetworkImage(path!));
    }
    return image(AssetImage(path!));
  }

  bool checkAsset() {
    if (path!.contains('assets')) {
      String firstString = path!.trim().substring(0, 5).toUpperCase();
      return firstString.contains('asset'.toUpperCase());
    }
    return false;
  }

  Image image(ImageProvider<Object> image) => Image(
        image: image,
        fit: fit,
        width: width,
        height: height,
        color: color,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return placeholder ?? _placeholder;
        },
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _errorWidget,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: _buildImage(),
    );
  }

  Widget get _defaultImage {
    return CachedNetworkImage(
        imageUrl:
            'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
        fit: fit,
        width: width,
        filterQuality: FilterQuality.medium,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 100),
        height: height,
        color: color,
        placeholder: (context, url) => placeholder ?? _placeholder,
        errorWidget: (context, url, error) => errorWidget ?? _errorWidget);
  }

  Widget _buildImage() {
    isRemote = checkRemote();
    if (isNullEmpty(path)) {
      return defultImage ?? _defaultImage;
    }
    switch (imageType) {
      case ImageType.file:
        return _buildFileImageWidget();
      case ImageType.svg:
        return _buildSvgImageWidget();
      default:
        return _buildNormalImageWidget();
    }
  }

  ImageType get imageType {
    int length = path!.length;
    String firstString = path!.substring(0, 5).toUpperCase();
    String lastString = path!.substring(length - 5).toUpperCase();
    if (lastString.contains('.svg'.toUpperCase())) {
      return ImageType.svg;
    } else if (firstString.contains('asset'.toUpperCase())) {
      return ImageType.image;
    } else {
      return ImageType.file;
    }
  }

  bool checkRemote() {
    if (path.toString().contains('http://') ||
        path.toString().contains('https://')) {
      return true;
    }
    return false;
  }
}

enum ImageType {
  svg,
  image,
  file,
}
