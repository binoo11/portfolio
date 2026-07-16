import 'package:flutter/material.dart';

import '../constant/app_constants.dart';

/// Ergonomic shortcuts on BuildContext to cut boilerplate (DRY).
extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  bool get isMobile => width < Breakpoints.tablet;
  bool get isTablet => width >= Breakpoints.tablet && width < Breakpoints.desktop;
  bool get isDesktop => width >= Breakpoints.desktop;
  bool get isUltraWide => width >= Breakpoints.ultraWide;

  /// Horizontal page padding that scales with viewport.
  double get pagePadding {
    if (isMobile) return 20;
    if (isTablet) return 40;
    if (isUltraWide) return 120;
    return 80;
  }
}