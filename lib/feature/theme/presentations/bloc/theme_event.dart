
import 'package:equatable/equatable.dart';

/// Events driving theme changes. Equatable for correct BLoC equality.
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Toggle between light and dark.
class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

/// Explicitly set a specific theme mode (e.g. from a settings control).
class ThemeModeSelected extends ThemeEvent {
  const ThemeModeSelected(this.isDark);

  final bool isDark;

  @override
  List<Object?> get props => <Object?>[isDark];
}