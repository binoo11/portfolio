import 'package:flutter/widgets.dart';

import '../constant/app_constants.dart';

/// Declarative responsive value/layout helper. Complements responsive_framework
/// for cases where we want to pick a value (not just scale) per breakpoint.
class Responsive {
  const Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < Breakpoints.tablet;

  static bool isTablet(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return w >= Breakpoints.tablet && w < Breakpoints.desktop;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.desktop;

  /// Returns the value matching the current breakpoint, falling back upward.
  static T value<T>(
      BuildContext context, {
        required T mobile,
        T? tablet,
        T? desktop,
        T? ultraWide,
      }) {
    final double w = MediaQuery.sizeOf(context).width;
    if (w >= Breakpoints.ultraWide && ultraWide != null) return ultraWide;
    if (w >= Breakpoints.desktop && desktop != null) return desktop;
    if (w >= Breakpoints.tablet && tablet != null) return tablet;
    return mobile;
  }
}

/// Widget-level responsive switcher for entirely different layouts per size.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobile,
    this.tablet,
    required this.desktop,
    super.key,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    if (w >= Breakpoints.desktop) return desktop;
    if (w >= Breakpoints.tablet) return tablet ?? desktop;
    return mobile;
  }
}