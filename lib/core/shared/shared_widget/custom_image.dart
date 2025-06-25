// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.path, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.size,
    this.lottieRepeat,
  });

  final String path;
  final BoxFit? fit;
  final Color? color;
  final double? width, height, radius, size;
  final bool? lottieRepeat;
  static ImageProvider provider(String path) {
    final type = _getType(path);
    switch (type) {
      case 'asset':
        return AssetImage(path);
      case 'file':
        return FileImage(File(path));
      case 'network':
        return CachedNetworkImageProvider(path);
      default:
        throw Exception('Unsupported image type');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? getColor() => color;

    double? getSize() => size;

    final type = _getType(path);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 1),
      child: Builder(
        builder: (_) {
          switch (type) {
            case 'asset':
              return Image.asset(
                path,
                fit: fit,
                width: getSize()?.sp ?? width,
                color: getColor(),
                height: getSize()?.sp ?? height,
              );
            case 'file_uri':
              return Image.file(
                File.fromUri(Uri.parse(path)),
                fit: fit,
                width: getSize()?.sp ?? width,
                color: getColor(),
                height: getSize()?.sp ?? height,
              );
            case 'file':
              return Image.file(
                File(path),
                fit: fit,
                width: getSize()?.sp ?? width,
                color: getColor(),
                height: getSize()?.sp ?? height,
              );
            case 'base64':
              return Image.memory(
                base64Decode(_extractBase64Data(path)),
                fit: fit,
                width: getSize()?.sp ?? width,
                height: getSize()?.sp ?? height,
              );

            case 'network':
              return CachedNetworkImage(
                imageUrl: path,
                fit: fit,
                width: getSize()?.sp ?? width,
                height: getSize()?.sp ?? height,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => _errorWidget(),
              );
            default:
              return _errorWidget();
          }
        },
      ),
    );
  }

  Widget _errorWidget() {
    return const Icon(Icons.error, color: Colors.red);
  }

  static String _getType(String path) {
    if (path.startsWith('content://')) return 'file_uri';
    if (path.startsWith('assets/')) return 'asset';
    if (path.startsWith('data:image/')) return 'base64';
    if (path.startsWith('/')) return 'file';
    if (path.startsWith('http') || path.startsWith('https')) return 'network';
    return 'unsupported';
  }

  static String _extractBase64Data(String base64String) {
    return base64String.split(',').last;
  }
}
