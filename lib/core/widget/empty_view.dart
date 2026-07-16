import 'package:flutter/material.dart';

import '../constant/app_strings.dart';

/// Generic empty state used when a section has no data (e.g. certifications).
/// In practice sections hide themselves when empty; this is the fallback.
class EmptyView extends StatelessWidget {
  const EmptyView({this.title, this.icon, super.key});

  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon ?? Icons.inbox_rounded,
            size: 44,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          Text(
            title ?? AppStrings.emptyTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}