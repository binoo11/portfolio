import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Services section: responsive grid of service cards, each with a gradient
/// icon badge, title, and description.
class ServicesSection extends StatelessWidget {
  const ServicesSection({
    required this.sectionKey,
    required this.services,
    super.key,
  });

  final GlobalKey sectionKey;
  final List<ServiceItem> services;

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(eyebrow: 'What I Do', title: 'Services'),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = _columnsFor(constraints.maxWidth);
              const double spacing = 24;
              final double width =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: <Widget>[
                  for (int i = 0; i < services.length; i++)
                    SizedBox(
                      width: width,
                      child: _ServiceCard(service: services[i], index: i),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  int _columnsFor(double width) {
    if (width >= 1024) return 3;
    if (width >= 768) return 2;
    return 1;
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.index});

  final ServiceItem service;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Icon(_iconFor(service.icon), color: Colors.white, size: 26),
          ),
          const SizedBox(height: 18),
          Text(service.title, style: context.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            service.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms, duration: 450.ms).slideY(begin: 0.08, end: 0);
  }

  /// Maps the domain's framework-free icon key to a concrete IconData.
  /// Unrecognized keys fall back to a generic icon so new service
  /// categories never crash the UI.
  IconData _iconFor(String key) {
    switch (key.toLowerCase()) {
      case 'code':
      case 'development':
        return Icons.code_rounded;
      case 'mobile':
        return Icons.smartphone_rounded;
      case 'web':
        return Icons.language_rounded;
      case 'design':
      case 'ui_ux':
        return Icons.brush_rounded;
      case 'cloud':
        return Icons.cloud_outlined;
      case 'api':
      case 'backend':
        return Icons.dns_rounded;
      case 'consulting':
        return Icons.forum_rounded;
      case 'testing':
      case 'qa':
        return Icons.bug_report_outlined;
      case 'performance':
        return Icons.speed_rounded;
      case 'support':
      case 'maintenance':
        return Icons.build_rounded;
      default:
        return Icons.star_outline_rounded;
    }
  }
}