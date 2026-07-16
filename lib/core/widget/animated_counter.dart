import 'package:flutter/material.dart';

/// Counts from 0 to [value] when first built. Used for the animated stats
/// in the hero/about (years of experience, projects shipped, etc.).
class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    required this.value,
    this.suffix = '',
    this.duration = const Duration(milliseconds: 1400),
    this.textStyle,
    super.key,
  });

  final int value;
  final String suffix;
  final Duration duration;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, int current, _) {
        return Text(
          '$current$suffix',
          style: textStyle ?? Theme.of(context).textTheme.displaySmall,
        );
      },
    );
  }
}