import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/portfolio_models.dart';

class GitHubApiClient {
  final http.Client client;

  GitHubApiClient({required this.client});

  Future<List<GitHubRepo>> fetchUserRepos(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username/repos?sort=updated&per_page=6');
    try {
      final response = await client.get(url).timeout(const Duration(seconds: 4));
      
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => GitHubRepo.fromJson(item)).toList();
      } else {
        return _getMockRepos();
      }
    } catch (_) {
      return _getMockRepos();
    }
  }

  List<GitHubRepo> _getMockRepos() {
    return const [
      GitHubRepo(
        name: 'certificate_canvas',
        description: 'A performance-optimized Dart & Flutter package to generate and draw high-fidelity digital certificates using HTML Canvas and Flutter CustomPainter.',
        stars: 128,
        forks: 34,
        language: 'Dart',
        htmlUrl: 'https://github.com/okama-dev/certificate_canvas',
      ),
      GitHubRepo(
        name: 'flutter_clean_bloc',
        description: 'A premium architectural template implementing Clean Architecture, BLoC 8+, dynamic theme switches, local caching with Hive, and ready-made pipeline scripts.',
        stars: 342,
        forks: 89,
        language: 'Dart',
        htmlUrl: 'https://github.com/okama-dev/flutter_clean_bloc',
      ),
      GitHubRepo(
        name: 'shorebird_code_push_workflow',
        description: 'GitHub Action templates to automate over-the-air code pushes for Android and iOS devices utilizing the Shorebird CLI compiler.',
        stars: 64,
        forks: 12,
        language: 'YAML',
        htmlUrl: 'https://github.com/okama-dev/shorebird_code_push_workflow',
      ),
      GitHubRepo(
        name: 'crypto_offramp_sdk',
        description: 'Dart API wrapper and client bindings for major fiat off-ramp providers, featuring secure sign-offs, transaction tracking and WebSocket hooks.',
        stars: 92,
        forks: 18,
        language: 'Dart',
        htmlUrl: 'https://github.com/okama-dev/crypto_offramp_sdk',
      ),
    ];
  }
}
