import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Primary CTA button with the brand gradient, hover lift/scale, and an
/// optional leading icon. Fully accessible (Semantics + focus/hover states).
class GradientButton extends StatefulWidget {
  const GradientButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool filled;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final Color onColor =
    widget.filled ? Colors.white : Theme.of(context).colorScheme.onSurface;

    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
            padding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            decoration: BoxDecoration(
              gradient: widget.filled ? AppColors.brandGradient : null,
              color: widget.filled ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: widget.filled
                  ? null
                  : Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              boxShadow: widget.filled && _hovering
                  ? <BoxShadow>[
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.45),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.icon != null) ...<Widget>[
                  Icon(widget.icon, size: 18, color: onColor),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.label,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: onColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}