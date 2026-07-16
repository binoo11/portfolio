
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable theme state. `isDark` fully describes the UI; ThemeMode is derived.
class ThemeState extends Equatable {
  const ThemeState({required this.isDark});

  final bool isDark;

  /// Default the site to dark — matches the premium hero aesthetic.
  factory ThemeState.initial() => const ThemeState(isDark: true);

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeState copyWith({bool? isDark}) =>
      ThemeState(isDark: isDark ?? this.isDark);

  @override
  List<Object?> get props => <Object?>[isDark];
}