import '../../domain/entities/portfolio_entities.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/resume_local_data_source.dart';

/// Concrete repository. Today it reads from the local source; swap in a remote
/// dio-backed source later and neither domain nor presentation changes
/// (Dependency Inversion). The async signature already models that boundary.
class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._local);

  final ResumeLocalDataSource _local;

  @override
  Future<Portfolio> getPortfolio() async {
    // Simulated async boundary — a real remote fetch would await dio here.
    return _local.load();
  }
}