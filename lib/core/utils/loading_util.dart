import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class LoadingUtil {
  static BuildContext? _currentDialogContext;
  static bool _isShowing = false;

  static Future<void> show() async {
    if (_isShowing) {
      close();
    }

    _isShowing = true;

    showDialog(
      context: Zap.context,
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
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              )),
        );
      },
    );
  }

  static void close() {
  if (!_isShowing || _currentDialogContext == null) return;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_currentDialogContext != null) {
      try {
        Navigator.of(_currentDialogContext!).pop();
      } finally {
        _currentDialogContext = null;
        _isShowing = false;
      }
    }
  });

  }
}
