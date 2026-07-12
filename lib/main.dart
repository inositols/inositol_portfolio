import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'core/theme/app_theme.dart';
import 'features/portfolio/data/datasources/github_api_client.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'features/portfolio/presentation/bloc/theme/theme_cubit.dart';
import 'features/portfolio/presentation/pages/portfolio_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Clean Architecture Dependency Injections
  final httpClient = http.Client();
  final gitHubApiClient = GitHubApiClient(client: httpClient);
  final portfolioRepository = PortfolioRepositoryImpl(gitHubApiClient: gitHubApiClient);

  runApp(
    MyApp(portfolioRepository: portfolioRepository),
  );
}

class MyApp extends StatelessWidget {
  final PortfolioRepositoryImpl portfolioRepository;

  const MyApp({
    super.key,
    required this.portfolioRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PortfolioRepositoryImpl>.value(value: portfolioRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider<PortfolioBloc>(
            create: (context) => PortfolioBloc(
              repository: context.read<PortfolioRepositoryImpl>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: 'Okwuchukwu Okama | Senior Flutter Engineer Portfolio',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const PortfolioHomePage(),
            );
          },
        ),
      ),
    );
  }
}
