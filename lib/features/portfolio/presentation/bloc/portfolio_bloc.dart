import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../data/models/portfolio_models.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Cubit<PortfolioState> {
  final PortfolioRepository repository;

  PortfolioBloc({required this.repository}) : super(PortfolioInitial());

  Future<void> loadPortfolioData() async {
    emit(PortfolioLoading());
    try {
      final results = await Future.wait([
        repository.getProjects(),
        repository.getSkills(),
        repository.getExperiences(),
        repository.getBlogs(),
        repository.getTestimonials(),
        repository.getGitHubRepos(),
      ]);

      final List<Project> allProjects = results[0] as List<Project>;
      final List<Skill> skills = results[1] as List<Skill>;
      final List<Experience> experiences = results[2] as List<Experience>;
      final List<BlogPost> blogs = results[3] as List<BlogPost>;
      final List<String> testimonials = results[4] as List<String>;
      final List<GitHubRepo> githubRepos = results[5] as List<GitHubRepo>;

      emit(PortfolioLoaded(
        allProjects: allProjects,
        filteredProjects: allProjects,
        skills: skills,
        experiences: experiences,
        blogs: blogs,
        testimonials: testimonials,
        githubRepos: githubRepos,
      ));
    } catch (e) {
      emit(PortfolioError(message: e.toString()));
    }
  }

  void filterProjects(String query, String category) {
    if (state is! PortfolioLoaded) return;
    
    final loadedState = state as PortfolioLoaded;
    final List<Project> allProjects = loadedState.allProjects;
    
    List<Project> filtered = allProjects;

    // Apply category filter
    if (category != 'All') {
      filtered = filtered.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
    }

    // Apply search query filter
    if (query.trim().isNotEmpty) {
      final lowercaseQuery = query.toLowerCase().trim();
      filtered = filtered.where((p) {
        final matchesTitle = p.title.toLowerCase().contains(lowercaseQuery);
        final matchesSubtitle = p.subtitle.toLowerCase().contains(lowercaseQuery);
        final matchesDesc = p.description.toLowerCase().contains(lowercaseQuery);
        final matchesTech = p.technologies.any((tech) => tech.toLowerCase().contains(lowercaseQuery));
        return matchesTitle || matchesSubtitle || matchesDesc || matchesTech;
      }).toList();
    }

    emit(loadedState.copyWith(
      filteredProjects: filtered,
      activeCategory: category,
      searchQuery: query,
      contactStatus: ContactStatus.initial, // Reset contact status on action
    ));
  }

  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (state is! PortfolioLoaded) return;
    
    final loadedState = state as PortfolioLoaded;
    emit(loadedState.copyWith(contactStatus: ContactStatus.submitting));

    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Emit success
      emit((state as PortfolioLoaded).copyWith(contactStatus: ContactStatus.success));
    } catch (e) {
      emit((state as PortfolioLoaded).copyWith(
        contactStatus: ContactStatus.error,
        contactErrorMessage: e.toString(),
      ));
    }
  }

  void resetContactStatus() {
    if (state is! PortfolioLoaded) return;
    emit((state as PortfolioLoaded).copyWith(contactStatus: ContactStatus.initial));
  }
}
