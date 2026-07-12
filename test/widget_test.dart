import 'package:flutter_test/flutter_test.dart';
import 'package:inositol/main.dart';
import 'package:inositol/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:inositol/features/portfolio/data/datasources/github_api_client.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('Smoke test portfolio main page', (WidgetTester tester) async {
    final client = http.Client();
    final api = GitHubApiClient(client: client);
    final repo = PortfolioRepositoryImpl(gitHubApiClient: api);
    await tester.pumpWidget(MyApp(portfolioRepository: repo));
  });
}
