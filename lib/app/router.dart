import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../feature/portfolio/presentation/bloc/portfolio_bloc.dart';
import '../feature/portfolio/presentation/bloc/portfolio_event.dart';

import '../feature/portfolio/presentation/pages/home_page.dart';
import '../injection_container.dart';

export 'package:go_router/go_router.dart' show GoRouter;

/// Centralized routing. This is a single-page portfolio, so there is one route
/// that hosts the HomePage; all section navigation is in-page anchor scrolling
/// (which also avoids deep-link 404s on GitHub Pages). Kept in its own class so
/// additional routes (e.g. a dedicated case-study page) can be added cleanly.
class GoRouterConfig {
  GoRouterConfig();

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage<void>(child: _HomeProvider());
        },
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}

/// Provides a fresh PortfolioBloc (factory-scoped) to the HomePage and kicks
/// off the initial load. Separated so the router stays declarative.
class _HomeProvider extends StatelessWidget {
  const _HomeProvider();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortfolioBloc>(
      create: (_) => sl<PortfolioBloc>()..add(const PortfolioLoaded()),
      child: const HomePage(),
    );
  }
}