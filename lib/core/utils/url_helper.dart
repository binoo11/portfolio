import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Thin wrapper around url_launcher for external links, mailto, and tel.
/// Centralizes launch logic + error swallowing (DRY, testable seam).
class UrlHelper {
  const UrlHelper._();

  static Future<void> open(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }
  static Future<void> openAsset(String assetPath) async {
    if (kIsWeb) {
      // Flutter Web serves assets at /assets/<assetPath>.
      final Uri uri = Uri.base.resolve('assets/$assetPath');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint(
        'openAsset is only implemented for web. '
            'Use openAssetAsFile for mobile/desktop.',
      );
    }
  }

  static Future<void> email(String address, {String subject = ''}) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: address,
      query: subject.isEmpty ? null : 'subject=${Uri.encodeComponent(subject)}',
    );
    await launchUrl(uri);
  }

  static Future<void> phone(String number) async {
    await launchUrl(Uri(scheme: 'tel', path: number));
  }
}