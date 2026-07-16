import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Skills section: one glass card per category, each containing animated chips.
/// Chips stagger in on reveal. Grid adapts column count to viewport width.
class SkillsSection extends StatelessWidget {
  const SkillsSection({
    required this.sectionKey,
    required this.skillGroups,
    super.key,
  });

  final GlobalKey sectionKey;
  final List<SkillGroup> skillGroups;

  @override
  Widget build(BuildContext context) {
    final int columns = context.isMobile
        ? 1
        : context.isTablet
        ? 2
        : 3;

    return SectionWrapper(
      sectionKey: sectionKey,
      background: context.colors.surface.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(
            eyebrow: 'Skills',
            title: 'Skills & Expertise',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const double gap = 20;
              final double itemWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: <Widget>[
                  for (int i = 0; i < skillGroups.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: _SkillCard(group: skillGroups[i], index: i),
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

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.group, required this.index});

  final SkillGroup group;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(group.category, style: context.textTheme.titleMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (int i = 0; i < group.skills.length; i++)
                _SkillChip(label: group.skills[i])
                    .animate()
                    .fadeIn(delay: (60 * i).ms, duration: 350.ms)
                    .scaleXY(begin: 0.9, end: 1),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (120 * index).ms, duration: 450.ms)
        .slideY(begin: 0.15, end: 0);
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: _hovering
              ? AppColors.primary.withValues(alpha: 0.16)
              : context.colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _hovering ? AppColors.primary : context.colors.outline,
          ),
        ),
        child: Text(
          widget.label,
          style: context.textTheme.bodySmall?.copyWith(
            color: _hovering
                ? AppColors.primary
                : context.colors.onSurface.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}