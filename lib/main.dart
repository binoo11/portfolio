import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'app/router.dart';
import 'core/config/app_cofig.dart';
import 'core/constant/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'feature/navigation/presentation/bloc/navigation_bloc.dart';
import 'feature/theme/presentations/bloc/theme_bloc.dart';
import 'feature/theme/presentations/bloc/theme_state.dart';
import 'injection_container.dart' as di;

import '../injection_container.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

   HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory(
              (await getApplicationDocumentsDirectory()).path,
            ),
    );

  await di.configureDependencies();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late final GoRouterConfig _routerConfig;

  @override
  void initState() {
    super.initState();
    _routerConfig = GoRouterConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeBloc>.value(value: sl<ThemeBloc>()),
        BlocProvider<NavigationBloc>.value(value: sl<NavigationBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return MaterialApp.router(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.themeMode,
            routerConfig: _routerConfig.router,
            builder: (BuildContext context, Widget? child) {
              return ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: const <Breakpoint>[
                  Breakpoint(start: 0, end: Breakpoints.mobile, name: MOBILE),
                  Breakpoint(
                    start: Breakpoints.mobile + 1,
                    end: Breakpoints.tablet,
                    name: TABLET,
                  ),
                  Breakpoint(
                    start: Breakpoints.tablet + 1,
                    end: Breakpoints.desktop,
                    name: 'LAPTOP',
                  ),
                  Breakpoint(
                    start: Breakpoints.desktop + 1,
                    end: Breakpoints.ultraWide,
                    name: DESKTOP,
                  ),
                  Breakpoint(
                    start: Breakpoints.ultraWide + 1,
                    end: double.infinity,
                    name: '4K',
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
