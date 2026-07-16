import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';

/// Standard section heading: small gradient eyebrow label + large title,
/// with a subtle scroll-reveal animation. Keeps headings visually consistent.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.eyebrow,
    required this.title,
    this.center = false,
    super.key,
  });

  final String eyebrow;
  final String title;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment align =
    center ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect bounds) =>
              AppColors.brandGradient.createShader(bounds),
          child: Text(
            eyebrow.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }
}