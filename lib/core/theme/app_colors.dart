import 'package:flutter/material.dart';

/// Brand palette. Two schemes (light/dark) plus shared gradients and
/// glassmorphism tokens. Kept free of widget logic (SRP).
class AppColors {
  const AppColors._();

  // Brand accents (shared across themes)
  static const Color primary = Color(0xFF6C8CFF); // periwinkle blue
  static const Color primaryDeep = Color(0xFF4C6EF5);
  static const Color secondary = Color(0xFF9B7CFF); // violet
  static const Color accent = Color(0xFF33D6C7); // teal

  // Dark scheme
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF141A29);
  static const Color darkSurfaceAlt = Color(0xFF1B2233);
  static const Color darkOnSurface = Color(0xFFE7EAF3);
  static const Color darkMuted = Color(0xFF9AA4BF);
  static const Color darkBorder = Color(0x1AFFFFFF);

  // Light scheme
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEEF1FA);
  static const Color lightOnSurface = Color(0xFF141A29);
  static const Color lightMuted = Color(0xFF5B6580);
  static const Color lightBorder = Color(0x14000000);

  // Semantic
  static const Color success = Color(0xFF34D399);
  static const Color error = Color(0xFFF87171);

  // Signature gradient used on CTAs, hero accents, headings.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[primary, secondary],
  );

  static const LinearGradient auroraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[primary, secondary, accent],
  );

  /// Translucent fill used by glass cards, tuned per brightness.
  static Color glassFill(Brightness b) =>
      b == Brightness.dark ? const Color(0x14FFFFFF) : const Color(0xB3FFFFFF);

  static Color glassBorder(Brightness b) =>
      b == Brightness.dark ? const Color(0x1FFFFFFF) : const Color(0x14000000);
}