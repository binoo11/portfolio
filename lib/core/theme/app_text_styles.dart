import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography scale built on Google Fonts. `Sora` for display/headings,
/// `Inter` for body — a premium, modern pairing. Returns a full TextTheme
/// so Material components inherit correctly.
class AppTextStyles {
  const AppTextStyles._();

  static TextTheme textTheme(Color onSurface, Color muted) {
    final TextStyle display = GoogleFonts.sora(
      color: onSurface,
      fontWeight: FontWeight.w700,
      height: 1.05,
      letterSpacing: -0.5,
    );

    final TextStyle heading = GoogleFonts.sora(
      color: onSurface,
      fontWeight: FontWeight.w600,
      height: 1.15,
      letterSpacing: -0.25,
    );

    final TextStyle body = GoogleFonts.inter(
      color: onSurface,
      fontWeight: FontWeight.w400,
      height: 1.6,
    );

    return TextTheme(
      displayLarge: display.copyWith(fontSize: 64),
      displayMedium: display.copyWith(fontSize: 52),
      displaySmall: display.copyWith(fontSize: 40),
      headlineLarge: heading.copyWith(fontSize: 34),
      headlineMedium: heading.copyWith(fontSize: 28),
      headlineSmall: heading.copyWith(fontSize: 22),
      titleLarge: heading.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.inter(
        color: onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.inter(
        color: muted,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
      bodyLarge: body.copyWith(fontSize: 18, color: muted),
      bodyMedium: body.copyWith(fontSize: 16, color: muted),
      bodySmall: body.copyWith(fontSize: 14, color: muted),
      labelLarge: GoogleFonts.inter(
        color: onSurface,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}