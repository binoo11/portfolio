import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Education section: compact vertical timeline mirroring ExperienceSection's
/// visual language, sized down since entries carry less content.
class EducationSection extends StatelessWidget {
  const EducationSection({
    required this.sectionKey,
    required this.education,
    super.key,
  });

  final GlobalKey sectionKey;
  final List<EducationItem> education;

  @override
  Widget build(BuildContext context) {
    if (education.isEmpty) return const SizedBox.shrink();

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(eyebrow: 'Background', title: 'Education'),
          const SizedBox(height: 40),
          for (int i = 0; i < education.length; i++)
            _EducationEntry(
              item: education[i],
              isLast: i == education.length - 1,
              index: i,
            ),
        ],
      ),
    );
  }
}

class _EducationEntry extends StatelessWidget {
  const _EducationEntry({
    required this.item,
    required this.isLast,
    required this.index,
  });

  final EducationItem item;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.surface,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: context.colors.outline,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      children: <Widget>[
                        Text(item.degree, style: context.textTheme.titleMedium),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.duration,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.institution,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    if (item.description != null && item.description!.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 10),
                      Text(item.description!, style: context.textTheme.bodyMedium),
                    ],
                  ],
                ),
              ).animate().fadeIn(delay: (100 * index).ms, duration: 450.ms).slideX(begin: 0.08, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}