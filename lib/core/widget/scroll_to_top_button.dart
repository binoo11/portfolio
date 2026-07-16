import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../feature/navigation/presentation/bloc/navigation_bloc.dart';
import '../../feature/navigation/presentation/bloc/navigation_state.dart';
import '../constant/app_strings.dart';

/// Floating action button that appears once the user scrolls past the hero.
/// Visibility is driven by NavigationBloc (showBackToTop) via BlocSelector so
/// only this widget rebuilds on scroll — not the whole page.
class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NavigationBloc, NavigationState, bool>(
      selector: (NavigationState state) => state.showBackToTop,
      builder: (BuildContext context, bool visible) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 260),
          offset: visible ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 260),
            opacity: visible ? 1 : 0,
            child: IgnorePointer(
              ignoring: !visible,
              child: Semantics(
                button: true,
                label: AppStrings.backToTop,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.45),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}