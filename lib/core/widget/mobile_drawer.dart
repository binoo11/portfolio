import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/navigation/presentation/bloc/navigation_bloc.dart';
import '../../feature/navigation/presentation/bloc/navigation_state.dart';
import '../constant/app_constants.dart';

/// Slide-in navigation drawer for mobile/tablet. Lists every section and marks
/// the active one; tapping delegates to [onSelect] (which pops + requests).
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({required this.onSelect, super.key});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: ShaderMask(
                shaderCallback: (Rect b) =>
                    AppColors.brandGradient.createShader(b),
                child: Text(
                  'Binod Dangi',
                  style: context.textTheme.titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: SectionId.ordered
                    .where((String id) => id != SectionId.hero)
                    .map((String id) => _DrawerItem(id: id))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NavigationBloc, NavigationState, bool>(
      selector: (NavigationState s) => s.activeSection == id,
      builder: (BuildContext context, bool isActive) {
        return ListTile(
          title: Text(
            SectionId.labels[id]!,
            style: context.textTheme.labelLarge?.copyWith(
              color: isActive
                  ? AppColors.primary
                  : context.colors.onSurface.withValues(alpha: 0.8),
            ),
          ),
          leading: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 4,
            height: 22,
            decoration: BoxDecoration(
              gradient: isActive ? AppColors.brandGradient : null,
              color: isActive ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () =>
              (context.findAncestorWidgetOfExactType<MobileDrawer>())
                  ?.onSelect(id),
        );
      },
    );
  }
}