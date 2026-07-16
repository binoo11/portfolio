import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:portfolio/feature/theme/presentations/bloc/theme_event.dart';
import 'package:portfolio/feature/theme/presentations/bloc/theme_state.dart';


/// Manages light/dark theme. Extends HydratedBloc so the user's choice is
/// persisted locally (localStorage on web) and restored on next visit —
/// satisfying the "save selected theme locally" requirement without extra deps.
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeToggled>(_onToggled);
    on<ThemeModeSelected>(_onModeSelected);
  }

  void _onToggled(ThemeToggled event, Emitter<ThemeState> emit) {
    emit(state.copyWith(isDark: !state.isDark));
  }

  void _onModeSelected(ThemeModeSelected event, Emitter<ThemeState> emit) {
    emit(state.copyWith(isDark: event.isDark));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final Object? value = json['isDark'];
    if (value is bool) return ThemeState(isDark: value);
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) =>
      <String, dynamic>{'isDark': state.isDark};
}