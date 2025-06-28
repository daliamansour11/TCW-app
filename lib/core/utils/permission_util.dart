import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Checks if the device is Android 13 (SDK 33) or above.
  static Future<bool> isAndroid13OrAbove() async {
    if (!Platform.isAndroid) return false;
    final androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.version.sdkInt >= 33;
  }

  /// Generic permission checker
  static Future<bool> isGranted(Permission permission) async {
    return (await permission.status).isGranted;
  }

  /// Requests the appropriate permission for picking images.
  static Future<PermissionStatus> requestImagePermission() async {
    if (!Platform.isAndroid) {
      return await Permission.photos.request();
    }

    final isSdk32OrAbove = await isAndroid13OrAbove();
    if (isSdk32OrAbove) {
      // Android 13+ uses new permissions
      return await Permission.photos.request();
    } else {
      return await Permission.storage.request();
    }
  }

  /// Checks if the image permission is already granted.
  static Future<bool> isImagePermissionGranted() async {
    if (!Platform.isAndroid) {
      return await Permission.photos.isGranted;
    }

    final isSdk32OrAbove = await isAndroid13OrAbove();
    if (isSdk32OrAbove) {
      return await Permission.photos.isGranted;
    } else {
      return await Permission.storage.isGranted;
    }
  }

  /// Requests storage permission (for files in general).
  static Future<PermissionStatus> requestFilePermission() async {
    if (Platform.isAndroid) {
      return await Permission.storage.request();
    } else {
      // You can handle iOS here if needed
      return PermissionStatus.granted;
    }
  }

  /// Checks if storage permission is already granted.
  static Future<bool> isFilePermissionGranted() async {
    if (Platform.isAndroid) {
      return await Permission.storage.isGranted;
    } else {
      // You can handle iOS here if needed
      return true;
    }
  }

  /// Checks if permission is permanently denied (needs open app settings)
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    return (await permission.status).isPermanentlyDenied;
  }
}
