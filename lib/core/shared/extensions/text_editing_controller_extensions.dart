import 'package:flutter/material.dart';

extension TextEditingControllerExtensions on TextEditingController {
  String get value => text.trim();
  String? get valueOrNull => value.isEmpty ? null : value;
}