import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/github_api_client.dart';
import '../datasources/local_data.dart';
import '../models/portfolio_models.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final GitHubApiClient gitHubApiClient;

  PortfolioRepositoryImpl({required this.gitHubApiClient});

  @override
  Future<List<Project>> getProjects() async {
    return LocalData.projects;
  }

  @override
  Future<List<Skill>> getSkills() async {
    return LocalData.skills;
  }

  @override
  Future<List<Experience>> getExperiences() async {
    return LocalData.experiences;
  }

  @override
  Future<List<BlogPost>> getBlogs() async {
    return LocalData.blogs;
  }

  @override
  Future<List<String>> getTestimonials() async {
    return LocalData.testimonials;
  }

  @override
  Future<List<GitHubRepo>> getGitHubRepos() async {
    return gitHubApiClient.fetchUserRepos('inositols');
  }
}
