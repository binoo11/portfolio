import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Experience section: a vertical timeline. Each entry has a gradient node,
/// a connecting rail, and a glass card with role, duration, responsibilities,
/// key projects, and technology chips. Cards reveal on scroll.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({
    required this.sectionKey,
    required this.experience,
    super.key,
  });

  final GlobalKey sectionKey;
  final List<ExperienceItem> experience;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(
            eyebrow: 'Career',
            title: 'Professional Experience',
          ),
          const SizedBox(height: 40),
          for (int i = 0; i < experience.length; i++)
            _TimelineEntry(
              item: experience[i],
              isLast: i == experience.length - 1,
              index: i,
            ),
        ],
      ),
    );
  }
}

// class _TimelineEntry extends StatelessWidget {
//   const _TimelineEntry({
//     required this.item,
//     required this.isLast,
//     required this.index,
//   });
//
//   final ExperienceItem item;
//   final bool isLast;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicHeight(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           _rail(context),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 28),
//               child: _card(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _rail(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           width: 18,
//           height: 18,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: AppColors.brandGradient,
//           ),
//         ),
//         if (!isLast)
//           Expanded(
//             child: Container(
//               width: 2,
//               margin: const EdgeInsets.symmetric(vertical: 4),
//               color: context.colors.outline,
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _card(BuildContext context) {
//     return GlassCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             spacing: 12,
//             children: <Widget>[
//               Text(item.position, style: context.textTheme.titleLarge),
//               _durationPill(context),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             '${item.company}  ·  ${item.location}',
//             style: context.textTheme.titleSmall?.copyWith(
//               color: AppColors.primary,
//             ),
//           ),
//           const SizedBox(height: 16),
//           ...item.responsibilities.map(
//                 (String r) => Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8, right: 10),
//                     child: Container(
//                       width: 6,
//                       height: 6,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: AppColors.brandGradient,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(r, style: context.textTheme.bodyMedium),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (item.keyProjects.isNotEmpty) ...<Widget>[
//             const SizedBox(height: 8),
//             Text(
//               'Key projects: ${item.keyProjects.join(', ')}',
//               style: context.textTheme.bodySmall?.copyWith(
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ],
//           const SizedBox(height: 16),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: item.technologies
//                 .map((String t) => _techChip(context, t))
//                 .toList(),
//           ),
//         ],
//       ),
//     )
//         .animate()
//         .fadeIn(delay: (100 * index).ms, duration: 450.ms)
//         .slideX(begin: 0.08, end: 0);
//   }
//
//   Widget _durationPill(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//       decoration: BoxDecoration(
//         color: AppColors.primary.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         item.duration,
//         style: context.textTheme.bodySmall?.copyWith(
//           color: AppColors.primary,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   Widget _techChip(BuildContext context, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//       decoration: BoxDecoration(
//         color: context.colors.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: context.colors.outline),
//       ),
//       child: Text(label, style: context.textTheme.bodySmall),
//     );
//   }
// }
class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.item,
    required this.isLast,
    required this.index,
  });

  final ExperienceItem item;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Connector line — stretches to fill the real height of this
        // entry (dot to just above the next dot), no intrinsic sizing.
        if (!isLast)
          Positioned(
            left: 8, // centers under the 18px dot (18/2 - 2/2 = 8)
            top: 18,
            bottom: 0,
            child: Container(
              width: 2,
              color: context.colors.outline,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.brandGradient,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(child: _card(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            children: <Widget>[
              Text(item.position, style: context.textTheme.titleLarge),
              _durationPill(context),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${item.company}  ·  ${item.location}',
            style: context.textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...item.responsibilities.map(
                (String r) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 10),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.brandGradient,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(r, style: context.textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          ),
          if (item.keyProjects.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Text(
              'Key projects: ${item.keyProjects.join(', ')}',
              style: context.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: item.technologies
                .map((String t) => _techChip(context, t))
                .toList(),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (100 * index).ms, duration: 450.ms)
        .slideX(begin: 0.08, end: 0);
  }

  Widget _durationPill(BuildContext context) {
    return Container(
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
    );
  }

  Widget _techChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.outline),
      ),
      child: Text(label, style: context.textTheme.bodySmall),
    );
  }
}