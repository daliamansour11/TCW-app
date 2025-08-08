import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class LoadingUtil {
  static BuildContext? _currentDialogContext;
  static bool _isShowing = false;

  static Future<void> show([BuildContext? context]) async {
    if (_isShowing) {
      close();
    }

    _isShowing = true;

    showDialog(
      context: context ?? Zap.context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _currentDialogContext = dialogContext;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            width: 40.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }


  static void close() {
    if (!_isShowing || _currentDialogContext == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (Navigator.of(_currentDialogContext!).canPop()) {
          Navigator.of(_currentDialogContext!).pop();
        }
      } catch (_) {
      } finally {
        _currentDialogContext = null;
        _isShowing = false;
      }
    });
  }

  static bool get isLoading => _isShowing;
}
