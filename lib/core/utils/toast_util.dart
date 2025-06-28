import 'package:flutter/material.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:toastification/toastification.dart';

class ToastUtil {
  static Future show(String msg, [bool isError = false]) async {
    logger.d(msg);
    if (_runItems.isNotEmpty) {
      for (final item in _runItems) {
        item.stop();
      }
      _runItems.clear();
    }
    final item = toastification.show(
      title: Text(msg),
      type: isError ? ToastificationType.error : ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
    );
    _runItems.add(item);
    await Future.delayed(const Duration(seconds: 3));
    _runItems.remove(item);
    item.stop();
  }

  static final List<ToastificationItem> _runItems = [];
}
