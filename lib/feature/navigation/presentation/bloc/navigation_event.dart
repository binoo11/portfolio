import 'package:equatable/equatable.dart';

/// Events for tracking and requesting section navigation.
sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Fired by the scroll listener when the visible section changes.
class SectionChanged extends NavigationEvent {
  const SectionChanged(this.sectionId);

  final String sectionId;

  @override
  List<Object?> get props => <Object?>[sectionId];
}

/// Fired when the user taps a nav item; the page listens and smooth-scrolls.
class SectionRequested extends NavigationEvent {
  const SectionRequested(this.sectionId);

  final String sectionId;

  @override
  List<Object?> get props => <Object?>[sectionId];
}

/// Toggles visibility of the scroll-to-top button based on scroll offset.
class ScrollOffsetChanged extends NavigationEvent {
  const ScrollOffsetChanged(this.showBackToTop);

  final bool showBackToTop;

  @override
  List<Object?> get props => <Object?>[showBackToTop];
}