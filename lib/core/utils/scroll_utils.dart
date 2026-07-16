import 'package:flutter/widgets.dart';

import '../config/app_cofig.dart';

/// Smooth-scrolls a target section into view using its GlobalKey.
/// Used by the nav bar, drawer, and hero CTAs to jump between sections.
class ScrollUtils {
  const ScrollUtils._();

  static Future<void> scrollToKey(
      GlobalKey key, {
        Duration? duration,
        double alignment = 0.0,
      }) async {
    final BuildContext? ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: duration ?? AppConfig.scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment,
    );
  }

  static Future<void> scrollToTop(ScrollController controller) async {
    if (!controller.hasClients) return;
    await controller.animateTo(
      0,
      duration: AppConfig.scrollDuration,
      curve: Curves.easeInOutCubic,
    );
  }
}