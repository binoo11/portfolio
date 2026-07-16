import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';

import '../../feature/navigation/presentation/bloc/navigation_bloc.dart';
import '../../feature/navigation/presentation/bloc/navigation_event.dart';
import '../../feature/navigation/presentation/bloc/navigation_state.dart';
import '../../feature/theme/presentations/bloc/theme_bloc.dart';
import '../../feature/theme/presentations/bloc/theme_event.dart';
import '../../feature/theme/presentations/bloc/theme_state.dart';
import '../config/app_cofig.dart';
import '../constant/app_constants.dart';
import '../constant/app_strings.dart';
import 'glass_card.dart';

/// Sticky top navigation. On desktop it shows all section links with an active
/// indicator + a theme toggle. On mobile/tablet it collapses to a brand mark
/// and a hamburger that opens the end drawer.
class NavBar extends StatelessWidget {
  const NavBar({
    required this.onSelect,
    required this.onMenuTap,
    super.key,
  });

  final ValueChanged<String> onSelect;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final bool compact = context.isMobile || context.isTablet;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.pagePadding,
        vertical: 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
          const BoxConstraints(maxWidth: AppConfig.maxContentWidth),
          child: GlassCard(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 18 : 26,
              vertical: 10,
            ),
            borderRadius: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _BrandMark(),
                if (compact)
                  Row(
                    children: <Widget>[
                      const _ThemeToggle(),
                      const SizedBox(width: 4),
                      IconButton(
                        tooltip: AppStrings.semanticMenu,
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: onMenuTap,
                      ),
                    ],
                  )
                else
                  Row(
                    children: <Widget>[
                      ..._buildLinks(context),
                      const SizedBox(width: 12),
                      const _ThemeToggle(),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLinks(BuildContext context) {
    return SectionId.ordered
    // The hero has its own brand mark; skip it in the link row.
        .where((String id) => id != SectionId.hero)
        .map(
          (String id) => _NavLink(
        id: id,
        label: SectionId.labels[id]!,
        onTap: () => onSelect(id),
      ),
    )
        .toList(growable: false);
  }
}

class _BrandMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<NavigationBloc>()
          .add(const SectionRequested(SectionId.hero)),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: ShaderMask(
          shaderCallback: (Rect b) =>
              AppColors.brandGradient.createShader(b),
          child: Text(
            'BD',
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.id, required this.label, required this.onTap});

  final String id;
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NavigationBloc, NavigationState, bool>(
      selector: (NavigationState state) => state.activeSection == widget.id,
      builder: (BuildContext context, bool isActive) {
        final Color color = isActive || _hovering
            ? AppColors.primary
            : context.colors.onSurface.withValues(alpha: 0.75);
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.label,
                    style: context.textTheme.labelLarge?.copyWith(color: color),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    height: 2,
                    width: isActive ? 20 : 0,
                    decoration: BoxDecoration(
                      gradient: AppColors.brandGradient,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return IconButton(
          tooltip: AppStrings.semanticThemeToggle,
          onPressed: () =>
              context.read<ThemeBloc>().add(const ThemeToggled()),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> anim) =>
                RotationTransition(turns: anim, child: child),
            child: Icon(
              state.isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey<bool>(state.isDark),
            ),
          ),
        );
      },
    );
  }
}