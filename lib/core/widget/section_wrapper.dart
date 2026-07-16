import 'package:flutter/material.dart';

import '../config/app_cofig.dart';
import '../extensions/context_extensions.dart';

/// Consistent vertical rhythm + max-width clamp + horizontal padding for every
/// section. Attaches a GlobalKey so the nav can smooth-scroll to it.
class SectionWrapper extends StatelessWidget {
  const SectionWrapper({
    required this.sectionKey,
    required this.child,
    this.background,
    super.key,
  });

  final GlobalKey sectionKey;
  final Widget child;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final double vertical = context.isMobile ? 64 : 112;
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(
        horizontal: context.pagePadding,
        vertical: vertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
          const BoxConstraints(maxWidth: AppConfig.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}