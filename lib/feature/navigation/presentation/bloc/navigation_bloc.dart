import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';


/// Owns navigation UI state: active section highlight, scroll requests from
/// nav taps, and back-to-top visibility. Pure state — the page performs the
/// actual scrolling by listening for [NavigationState.requestedSection].
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<SectionChanged>(_onSectionChanged);
    on<SectionRequested>(_onSectionRequested);
    on<ScrollOffsetChanged>(_onScrollOffsetChanged);
  }

  void _onSectionChanged(SectionChanged event, Emitter<NavigationState> emit) {
    if (event.sectionId == state.activeSection) return;
    emit(state.copyWith(activeSection: event.sectionId));
  }

  void _onSectionRequested(
      SectionRequested event,
      Emitter<NavigationState> emit,
      ) {
    emit(
      state.copyWith(
        requestedSection: event.sectionId,
        activeSection: event.sectionId,
      ),
    );
    // Immediately clear so repeated taps on the same section re-trigger.
    emit(state.copyWith(clearRequested: true));
  }

  void _onScrollOffsetChanged(
      ScrollOffsetChanged event,
      Emitter<NavigationState> emit,
      ) {
    if (event.showBackToTop == state.showBackToTop) return;
    emit(state.copyWith(showBackToTop: event.showBackToTop));
  }
}