import 'package:get_it/get_it.dart';

import 'feature/navigation/presentation/bloc/navigation_bloc.dart';
import 'feature/portfolio/data/datasources/resume_local_data_source.dart';
import 'feature/portfolio/data/repository_impl/portfolio_repository_impl.dart';
import 'feature/portfolio/domain/repositories/portfolio_repository.dart';
import 'feature/portfolio/domain/usecases/get_portfolio.dart';
import 'feature/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'feature/theme/presentations/bloc/theme_bloc.dart';


/// Global service locator. Manual GetIt wiring is used here (over Injectable
/// codegen) so the whole dependency graph is explicit and reviewable in one
/// place. Registration order respects the clean-architecture inward flow:
/// data source -> repository -> use case -> bloc.
final GetIt sl = GetIt.instance;

/// Called once from main() before runApp(). Idempotent-safe for hot restart.
Future<void> configureDependencies() async {
  // ---- Data sources ----
  sl.registerLazySingleton<ResumeLocalDataSource>(
        () => const ResumeLocalDataSourceImpl(),
  );

  // ---- Repositories ----
  sl.registerLazySingleton<PortfolioRepository>(
        () => PortfolioRepositoryImpl(sl<ResumeLocalDataSource>()),
  );

  // ---- Use cases ----
  sl.registerLazySingleton<GetPortfolio>(
        () => GetPortfolio(sl<PortfolioRepository>()),
  );

  // ---- BLoCs ----
  // ThemeBloc + NavigationBloc are singletons (app-wide UI state).
  sl.registerLazySingleton<ThemeBloc>(ThemeBloc.new);
  sl.registerLazySingleton<NavigationBloc>(NavigationBloc.new);

  // PortfolioBloc is a factory: a fresh instance per provider mount.
  sl.registerFactory<PortfolioBloc>(() => PortfolioBloc(sl<GetPortfolio>()));
}