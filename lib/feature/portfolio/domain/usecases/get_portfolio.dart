import '../entities/portfolio_entities.dart';
import '../repositories/portfolio_repository.dart';

/// Single-responsibility use case: retrieve the full portfolio aggregate.
/// Callable via `getPortfolio()` thanks to `call`, keeping the BLoC clean.
class GetPortfolio {
  const GetPortfolio(this._repository);

  final PortfolioRepository _repository;

  Future<Portfolio> call() => _repository.getPortfolio();
}