import 'package:equatable/equatable.dart';

import '../../domain/entities/portfolio_entities.dart';

/// Status enum keeps state exhaustive and cheap to compare (no stringly logic).
enum PortfolioStatus { initial, loading, success, failure }

/// Single immutable state for the portfolio. Presentation switches on [status]
/// to render loading / error / content, satisfying the required UI states.
class PortfolioState extends Equatable {
  const PortfolioState({
    this.status = PortfolioStatus.initial,
    this.portfolio,
    this.errorMessage,
  });

  final PortfolioStatus status;
  final Portfolio? portfolio;
  final String? errorMessage;

  bool get isLoading =>
      status == PortfolioStatus.initial || status == PortfolioStatus.loading;
  bool get isSuccess => status == PortfolioStatus.success && portfolio != null;
  bool get isFailure => status == PortfolioStatus.failure;

  PortfolioState copyWith({
    PortfolioStatus? status,
    Portfolio? portfolio,
    String? errorMessage,
  }) {
    return PortfolioState(
      status: status ?? this.status,
      portfolio: portfolio ?? this.portfolio,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, portfolio, errorMessage];
}