import 'package:flutter/material.dart';

abstract final class StartupSenseColors {
  static const ink = Color(0xFF17172F);
  static const violet = Color(0xFF7356D8);
  static const lavender = Color(0xFFF0ECFF);
  static const lime = Color(0xFFD8F27A);
  static const canvas = Color(0xFFF8F8FC);
  static const line = Color(0xFFE8E8F0);
  static const muted = Color(0xFF74758A);
  static const teal = Color(0xFF2C8A79);
  static const paleTeal = Color(0xFFE6F5F1);

  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: violet,
    onPrimary: Colors.white,
    secondary: lime,
    onSecondary: ink,
    error: Color(0xFFB4233E),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: ink,
    surfaceContainerHighest: Color(0xFFF0F0F6),
    onSurfaceVariant: muted,
    outline: line,
  );
}
