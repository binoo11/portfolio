import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'animated_counter.dart';
import 'glass_card.dart';

/// About section: professional biography from the CV plus animated stat
/// counters (years of experience, roles held, projects shipped).
class AboutSection extends StatelessWidget {
  const AboutSection({
    required this.sectionKey,
    required this.profile,
    required this.experienceCount,
    required this.projectCount,
    super.key,
  });

  final GlobalKey sectionKey;
  final Profile profile;
  final int experienceCount;
  final int projectCount;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(eyebrow: 'About', title: 'About Me'),
          const SizedBox(height: 40),
          context.isMobile
              ? Column(
            children: <Widget>[
              _bio(context),
              const SizedBox(height: 28),
              _stats(context),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 3, child: _bio(context)),
              const SizedBox(width: 40),
              Expanded(flex: 2, child: _stats(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bio(BuildContext context) {
    return Text(
      profile.summary,
      style: context.textTheme.bodyLarge,
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15);
  }

  Widget _stats(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: <Widget>[
          _StatTile(
            value: profile.yearsExperience,
            suffix: '+',
            label: 'Years of experience',
          ),
          const Divider(height: 32),
          _StatTile(
            value: experienceCount,
            suffix: '',
            label: 'Companies & roles',
          ),
          const Divider(height: 32),
          _StatTile(
            value: projectCount,
            suffix: '+',
            label: 'Featured projects',
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(begin: 0.15);
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.suffix,
    required this.label,
  });

  final int value;
  final String suffix;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect b) => AppColors.brandGradient.createShader(b),
          child: AnimatedCounter(
            value: value,
            suffix: suffix,
            textStyle: context.textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(label, style: context.textTheme.bodyMedium),
        ),
      ],
    );
  }
}