abstract class PortfolioEvent {
  const PortfolioEvent();
}

class LoadPortfolioData extends PortfolioEvent {
  const LoadPortfolioData();
}

class FilterProjectsEvent extends PortfolioEvent {
  final String query;
  final String category;

  const FilterProjectsEvent({required this.query, required this.category});
}

class SubmitContactFormEvent extends PortfolioEvent {
  final String name;
  final String email;
  final String subject;
  final String message;

  const SubmitContactFormEvent({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });
}
