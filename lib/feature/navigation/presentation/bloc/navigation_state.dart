
import 'package:equatable/equatable.dart';

import '../../../../core/constant/app_constants.dart';

/// Navigation UI state: which section is active, an optional pending
/// scroll request, and whether the back-to-top button should show.
class NavigationState extends Equatable {
  const NavigationState({
    required this.activeSection,
    this.requestedSection,
    this.showBackToTop = false,
  });

  final String activeSection;

  /// Set when a nav tap requests a scroll; the page consumes and clears it.
  final String? requestedSection;

  final bool showBackToTop;

  factory NavigationState.initial() =>
      const NavigationState(activeSection: SectionId.hero);

  NavigationState copyWith({
    String? activeSection,
    String? requestedSection,
    bool clearRequested = false,
    bool? showBackToTop,
  }) {
    return NavigationState(
      activeSection: activeSection ?? this.activeSection,
      requestedSection:
      clearRequested ? null : (requestedSection ?? this.requestedSection),
      showBackToTop: showBackToTop ?? this.showBackToTop,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[activeSection, requestedSection, showBackToTop];
}