import '../../data/models/portfolio_models.dart';

enum ContactStatus { initial, submitting, success, error }

abstract class PortfolioState {
  const PortfolioState();
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final List<Project> allProjects;
  final List<Project> filteredProjects;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<BlogPost> blogs;
  final List<String> testimonials;
  final List<GitHubRepo> githubRepos;
  
  final String activeCategory;
  final String searchQuery;
  final ContactStatus contactStatus;
  final String? contactErrorMessage;

  const PortfolioLoaded({
    required this.allProjects,
    required this.filteredProjects,
    required this.skills,
    required this.experiences,
    required this.blogs,
    required this.testimonials,
    required this.githubRepos,
    this.activeCategory = 'All',
    this.searchQuery = '',
    this.contactStatus = ContactStatus.initial,
    this.contactErrorMessage,
  });

  PortfolioLoaded copyWith({
    List<Project>? allProjects,
    List<Project>? filteredProjects,
    List<Skill>? skills,
    List<Experience>? experiences,
    List<BlogPost>? blogs,
    List<String>? testimonials,
    List<GitHubRepo>? githubRepos,
    String? activeCategory,
    String? searchQuery,
    ContactStatus? contactStatus,
    String? contactErrorMessage,
  }) {
    return PortfolioLoaded(
      allProjects: allProjects ?? this.allProjects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      skills: skills ?? this.skills,
      experiences: experiences ?? this.experiences,
      blogs: blogs ?? this.blogs,
      testimonials: testimonials ?? this.testimonials,
      githubRepos: githubRepos ?? this.githubRepos,
      activeCategory: activeCategory ?? this.activeCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      contactStatus: contactStatus ?? this.contactStatus,
      contactErrorMessage: contactErrorMessage ?? this.contactErrorMessage,
    );
  }
}

class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError({required this.message});
}
