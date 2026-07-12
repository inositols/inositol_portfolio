import '../../data/models/portfolio_models.dart';

abstract class PortfolioRepository {
  Future<List<Project>> getProjects();
  Future<List<Skill>> getSkills();
  Future<List<Experience>> getExperiences();
  Future<List<BlogPost>> getBlogs();
  Future<List<String>> getTestimonials();
  Future<List<GitHubRepo>> getGitHubRepos();
}
