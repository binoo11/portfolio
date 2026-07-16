import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';

/// Site footer: name/tagline, quick social links, and a copyright line with
/// a dynamically computed year.
class FooterSection extends StatelessWidget {
  const FooterSection({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final int year = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colors.outline))),
      child: Column(
        children: <Widget>[
          Text(profile.name,
              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            profile.headline,
            style: context.textTheme.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            children: <Widget>[
              if (profile.social.github != null)
                _icon(context, Icons.code_rounded, profile.social.github!),
              if (profile.social.linkedin != null)
                _icon(context, Icons.business_center_outlined, profile.social.linkedin!),
              _icon(context, Icons.email_outlined, 'mailto:${profile.social.email}'),
              if (profile.social.whatsapp != null)
                _icon(context, Icons.chat_bubble_outline_rounded,
                    'https://wa.me/${profile.social.whatsapp}'),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© $year ${profile.name}. All rights reserved.',
            style: context.textTheme.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _icon(BuildContext context, IconData icon, String url) {
    return InkWell(
      onTap: () => _launch(url),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}