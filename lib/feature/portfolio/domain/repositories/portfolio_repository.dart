import '../entities/portfolio_entities.dart';

/// Abstraction owned by the domain. The data layer provides the concrete
/// implementation, so presentation depends on this interface only
/// (Dependency Inversion — the "D" in SOLID).
abstract interface class PortfolioRepository {
  Future<Portfolio> getPortfolio();
}