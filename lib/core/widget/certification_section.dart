import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Certifications section. Renders nothing when the list is empty so callers
/// can pass this in unconditionally without an extra `if` in the page tree.
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({
    required this.sectionKey,
    required this.certifications,
    super.key,
  });

  final GlobalKey sectionKey;
  final List<CertificationItem> certifications;

  @override
  Widget build(BuildContext context) {
    if (certifications.isEmpty) return const SizedBox.shrink();

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(eyebrow: 'Credentials', title: 'Certifications'),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = constraints.maxWidth >= 768 ? 2 : 1;
              const double spacing = 20;
              final double width =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: <Widget>[
                  for (int i = 0; i < certifications.length; i++)
                    SizedBox(
                      width: width,
                      child: _CertificationCard(item: certifications[i], index: i),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CertificationCard extends StatelessWidget {
  const _CertificationCard({required this.item, required this.index});

  final CertificationItem item;
  final int index;

  bool get _hasCredential => item.credentialUrl != null && item.credentialUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.title, style: context.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  '${item.issuer}  ·  ${item.date}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                if (_hasCredential) ...<Widget>[
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _launch(item.credentialUrl!),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'View credential',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_outward_rounded, size: 14, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms, duration: 450.ms).slideY(begin: 0.08, end: 0);
  }

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}