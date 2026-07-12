class Project {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String category; // 'Mobile' | 'Web' | 'Package' | 'Other'
  final List<String> technologies;
  final List<String> features;
  final String role;
  final String? githubUrl;
  final String? playStoreUrl;
  final String? liveDemoUrl;

  const Project({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.technologies,
    required this.features,
    required this.role,
    this.githubUrl,
    this.playStoreUrl,
    this.liveDemoUrl,
  });
}

class Skill {
  final String name;
  final String category; // 'Languages' | 'Backend' | 'Architecture' | 'Tools'
  final double level; // 0.0 to 1.0 representation
  final String iconAsset; // (optional) or generic icon mapping

  const Skill({
    required this.name,
    required this.category,
    required this.level,
    this.iconAsset = '',
  });
}

class Experience {
  final String id;
  final String company;
  final String role;
  final String period;
  final String location;
  final List<String> responsibilities;
  final String companyUrl;

  const Experience({
    required this.id,
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.responsibilities,
    required this.companyUrl,
  });
}

class BlogPost {
  final String id;
  final String title;
  final String summary;
  final String date;
  final String readTime;
  final String url;
  final List<String> tags;

  const BlogPost({
    required this.id,
    required this.title,
    required this.summary,
    required this.date,
    required this.readTime,
    required this.url,
    required this.tags,
  });
}

class GitHubRepo {
  final String name;
  final String description;
  final int stars;
  final int forks;
  final String language;
  final String htmlUrl;

  const GitHubRepo({
    required this.name,
    required this.description,
    required this.stars,
    required this.forks,
    required this.language,
    required this.htmlUrl,
  });

  factory GitHubRepo.fromJson(Map<String, dynamic> json) {
    return GitHubRepo(
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description provided.',
      stars: json['stargazers_count'] ?? 0,
      forks: json['forks_count'] ?? 0,
      language: json['language'] ?? 'Dart',
      htmlUrl: json['html_url'] ?? '',
    );
  }
}
