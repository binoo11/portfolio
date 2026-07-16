
import 'package:equatable/equatable.dart';

/// Events for loading the portfolio aggregate.
sealed class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Requests an initial (or retried) load of the resume-backed portfolio.
class PortfolioLoaded extends PortfolioEvent {
  const PortfolioLoaded();
}