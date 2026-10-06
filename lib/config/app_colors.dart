import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color brandBlue = Color(0xFF005B96);
  static const Color brandBlueDark = Color(0xFF003D63);
  static const Color brandBlueLight = Color(0xFFE7F0F7);
  static const Color brandTeal = brandBlue;
  static const Color brandTealDark = brandBlueDark;
  static const Color brandTealLight = brandBlueLight;
  static const Color brandRed = Color(0xFFB00018);
  static const Color brandRedDark = Color(0xFF870014);
  static const Color brandRedLight = Color(0xFFF9E5E8);
  static const Color brandRedMuted = Color(0xFFEBC2C8);

  static const Color primaryTiffany = brandBlue;
  static const Color primaryTiffanyDark = brandBlueDark;
  static const Color primaryTiffanyLight = brandBlueLight;
  static const Color accentRed = brandRed;

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF7F9FC);
  static const Color cardSurface = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF0B1220);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkCardBg = Color(0xFF131F2F);

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = primaryTiffany;
  static const Color error = Color(0xFFEF4444);
  static const Color loadingRed = brandBlue;
  static const Color loadingGreen = Color(0xFF22C55E);
  static const Color faluRed = brandRed;
  static const Color faluMist = primaryTiffanyLight; // legacy alias → teal light
  static const Color actionRed = brandRed;
  static const Color darkSurfaceAlt = Color(0xFF172133);

  static const Color chartPrimary = primaryTiffany;
  static const Color chartSecondary = primaryTiffanyDark;
  static const Color chartPositive = success;
  static const Color chartNegative = error;
  static const Color gridLine = Color(0xFFE5E7EB);

  static const Color lockedState = error;
  static const Color unlockedState = success;

  static const LinearGradient flatTiffanyGradient = LinearGradient(
    colors: [primaryTiffany, primaryTiffanyDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient flatTiffanyLightGradient = LinearGradient(
    colors: [primaryTiffanyLight, primaryTiffany],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient flatSurfaceGradient = LinearGradient(
    colors: [surface, surface],
  );
  static const LinearGradient brandRedGradient = LinearGradient(
    colors: [brandRed, brandRedDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color primaryRed = brandBlue;
  static const Color secondaryBlue = brandBlueDark;
  static const Color tiffanyBlue = primaryTiffany;
  static const Color tiffanyBlueLight = primaryTiffanyLight;
  static const Color tiffanyBlueDark = primaryTiffanyDark;
  static const Color tiffanyBlueGlow = Color(0x8C007E87);
  static const Color tiffanyBlueMuted = Color(0xFFC9E2E4);
  static const Color tiffanyMist = primaryTiffanyLight;

  static const Color abyssalTeal = tiffanyBlue;
  static const Color abyssalTealLight = tiffanyBlueLight;
  static const Color abyssalTealMuted = tiffanyBlueMuted;
  static const Color crimsonBurgundy = brandRedDark;
  static const Color crimsonBurgundyLight = brandRedLight;
  static const Color crimsonBurgundyMuted = brandRedMuted;
  static const Color brightCrimson = brandRed;
  static const Color brightCrimsonLight = brandRedLight;
  static const Color brightCrimsonMuted = brandRedMuted;
  static const Color backgroundLight = background;
  static const Color shellOverlay = surfaceSoft;
  static const Color surfaceMist = primaryTiffanyLight;
  static const Color black = textPrimary;
  static const Color blackPrimary = textPrimary;
  static const Color blackSecondary = textPrimary;
  static const Color blackTertiary = textSecondary;
  static const Color blackGlass = Color(0x14000000);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF94A3B8);
  static const Color cardBg = cardSurface;
  static const Color surfaceLight = surface;
  static const Color darkBorder = border;
  static const Color darkBorderLight = borderLight;
  static const Color darkCardBorder = borderLight;

  static const LinearGradient tealgradient = flatTiffanyGradient;
  static const LinearGradient crimsonGradient = brandRedGradient;
  static const LinearGradient brightCrimsonGradient = brandRedGradient;
  static const LinearGradient premiumGradient = flatTiffanyGradient;
  static const LinearGradient lightCardGradient = flatSurfaceGradient;
  static const LinearGradient darkCardGradient = flatSurfaceGradient;
  static const LinearGradient glassGradient = flatSurfaceGradient;
  static const LinearGradient darkGlassGradient = flatSurfaceGradient;
  static const LinearGradient tiffanyGradient = flatTiffanyGradient;
  static const LinearGradient faluTopBarGradient = flatTiffanyGradient;
  static const LinearGradient faluRedGradient = brandRedGradient;
  static const LinearGradient nzeruGradient = flatTiffanyGradient;
  static const LinearGradient lightGradient = flatSurfaceGradient;
  static const LinearGradient cardGradient = flatSurfaceGradient;
  static const LinearGradient redGradient = brandRedGradient;
  static const LinearGradient cryptoGradient = flatSurfaceGradient;
  static const LinearGradient cryptoCardGradient = flatSurfaceGradient;
  static const LinearGradient tiffanyGlassGradient = flatSurfaceGradient;
  static const LinearGradient redCryptoGradient = brandRedGradient;
}
