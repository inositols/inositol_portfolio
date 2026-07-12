import '../models/portfolio_models.dart';

class LocalData {
  static const List<Project> projects = [
    Project(
      id: 'jcommunity',
      title: 'J.Community',
      subtitle: 'Complete Event Management Ecosystem',
      description: 'A complete event management ecosystem supporting organizations and volunteers with QR Check-ins, ticketing, analytics, certificate generation, localization and offline mode.',
      category: 'Mobile',
      technologies: ['Flutter', 'Firebase', 'Bloc', 'Cloud Functions', 'Google Maps', 'Secure Storage'],
      features: ['QR Scanner', 'Volunteer Hours Tracking', 'Certificate Generator', 'Push Notifications', 'Role Management', 'Analytics Dashboard'],
      role: 'Lead Flutter Developer',
      githubUrl: 'https://github.com/okama-dev/jcommunity',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.jcommunity.app',
      liveDemoUrl: 'https://jcommunity.web.app',
    ),
    Project(
      id: 'bucapay',
      title: 'BucaPay',
      subtitle: 'Crypto Off-ramp Platform',
      description: 'A premium, highly secure cryptocurrency off-ramp platform enabling users to convert crypto instantly into fiat currency with automated bank transfers, localized payment channels, and strict security compliance.',
      category: 'Mobile',
      technologies: ['Flutter', 'Bloc', 'REST API', 'WebSockets', 'Biometrics', 'Hive'],
      features: ['Secure Crypto Wallet', 'Instant Fiat Payouts', 'Automated KYC Verification', 'Real-time Exchange Tickers', 'Multi-factor Authentication', 'Transaction History CSV Export'],
      role: 'Senior Flutter Engineer',
      githubUrl: 'https://github.com/okama-dev/bucapay',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.bucapay.app',
      liveDemoUrl: 'https://bucapay.com',
    ),
    Project(
      id: 'monami',
      title: 'Monami',
      subtitle: 'Next-Gen E-commerce App',
      description: 'A modern consumer-facing e-commerce shopping experience featuring real-time product catalogs, instant checkout options, payment gateways, custom animations, and automated shipping updates.',
      category: 'Mobile',
      technologies: ['Flutter', 'Riverpod', 'REST API', 'Stripe Integration', 'Hive', 'Lottie'],
      features: ['Dynamic Cart System', 'Stripe Payment Gateway', 'Multi-tenant Checkout', 'Order Status Tracking', 'Interactive Product Carousel', 'Offline Cache Sync'],
      role: 'Core Mobile Developer',
      githubUrl: 'https://github.com/okama-dev/monami',
      liveDemoUrl: 'https://monamishop.web.app',
    ),
    Project(
      id: 'healthlog',
      title: 'Health Log',
      subtitle: 'Personal Health Monitor',
      description: 'An offline-first, private health logging app that computes health markers, generates statistical charts, and offers personalized health suggestions via local machine learning models.',
      category: 'Mobile',
      technologies: ['Flutter', 'SQFlite', 'Bloc', 'Flutter Local Notifications', 'Fl Chart'],
      features: ['Blood Pressure Logger', 'Blood Sugar Tracker', 'BMI Calculator', 'Local Encrypted DB', 'Recurrent Med Reminders', 'AI Insights Report'],
      role: 'Solo Developer',
      githubUrl: 'https://github.com/okama-dev/healthlog',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.healthlog.app',
    ),
  ];

  static const List<Skill> skills = [
    // Languages
    Skill(name: 'Flutter', category: 'Languages', level: 0.98),
    Skill(name: 'Dart', category: 'Languages', level: 0.95),
    Skill(name: 'Python', category: 'Languages', level: 0.82),
    Skill(name: 'PHP', category: 'Languages', level: 0.75),

    // Backend
    Skill(name: 'Firebase', category: 'Backend', level: 0.92),
    Skill(name: 'Node.js', category: 'Backend', level: 0.80),
    Skill(name: 'REST APIs', category: 'Backend', level: 0.95),
    Skill(name: 'GraphQL', category: 'Backend', level: 0.78),

    // Architecture
    Skill(name: 'Clean Architecture', category: 'Architecture', level: 0.96),
    Skill(name: 'BLoC Pattern', category: 'Architecture', level: 0.98),
    Skill(name: 'Riverpod', category: 'Architecture', level: 0.90),
    Skill(name: 'SOLID Principles', category: 'Architecture', level: 0.95),
    Skill(name: 'MVVM', category: 'Architecture', level: 0.92),

    // Tools
    Skill(name: 'Git & GitHub', category: 'Tools', level: 0.92),
    Skill(name: 'Android Studio', category: 'Tools', level: 0.90),
    Skill(name: 'VS Code', category: 'Tools', level: 0.95),
    Skill(name: 'Figma', category: 'Tools', level: 0.85),
    Skill(name: 'Docker', category: 'Tools', level: 0.70),
  ];

  static const List<Experience> experiences = [
    Experience(
      id: 'bucapay_exp',
      company: 'BucaPay',
      role: 'Senior Flutter Engineer (Remote)',
      period: '2024 - Present',
      location: 'Lagos, Nigeria (Remote)',
      companyUrl: 'https://bucapay.com',
      responsibilities: [
        'Architected and maintained the premium crypto off-ramp platform using Clean Architecture and Bloc pattern, reducing codebase coupling by 40%.',
        'Implemented biometrics validation, hardware-backed secure storage, and dynamic screen obscuring for robust fintech-grade mobile security.',
        'Integrated real-time websocket connections to feed live token prices, achieving zero latency updates across user dashboards.',
        'Mentored 3 junior developers and established code review guidelines, leading to a 30% reduction in code review cycles.'
      ],
    ),
    Experience(
      id: 'getpouch_exp',
      company: 'GetPouch',
      role: 'Lead Mobile Developer',
      period: '2022 - 2024',
      location: 'Nairobi, Kenya (Remote)',
      companyUrl: 'https://getpouch.co',
      responsibilities: [
        'Spearheaded the rebuild of the Pouch mobile app using Flutter, achieving a unified codebase that replaced separate iOS and Android native apps.',
        'Implemented payment processing and Stripe gateway, processing over \$150k monthly in digital transactions with high reliability.',
        'Configured an offline-first caching framework using Hive DB and custom sync queues, offering seamless UX during network loss.',
        'Integrated dynamic push notifications via FCM, resulting in a 25% increase in user retention.'
      ],
    ),
    Experience(
      id: 'jejelove_exp',
      company: 'Jejelove',
      role: 'Mid-Level Flutter Developer',
      period: '2020 - 2022',
      location: 'Lagos, Nigeria (Hybrid)',
      companyUrl: 'https://jejelove.org',
      responsibilities: [
        'Created high-fidelity, interactive mobile user interfaces focusing on micro-animations and accessibility compliance.',
        'Leveraged Firebase Realtime Database and Cloud Firestore to develop multiplayer in-app social games and chat systems.',
        'Built automated testing flows using integration_test, saving the QA team roughly 12 hours of manual testing per release.'
      ],
    ),
    Experience(
      id: 'kleiba_exp',
      company: 'Kleiba Technologies',
      role: 'Software Developer Intern',
      period: '2019 - 2020',
      location: 'Enugu, Nigeria (Onsite)',
      companyUrl: 'https://kleiba.com',
      responsibilities: [
        'Developed fullstack features utilizing PHP (Laravel) and Python (Django) to build robust backend web services.',
        'Built interactive dashboards with HTML5, CSS3, and JavaScript, boosting user interactions by 18%.',
        'Wrote structural SQL scripts and managed migrations on PostgreSQL databases.'
      ],
    ),
  ];

  static const List<BlogPost> blogs = [
    BlogPost(
      id: 'blog_1',
      title: 'Mastering Clean Architecture in Flutter Web',
      summary: 'An in-depth guide on decoupling UI, business logic, and API clients in massive Flutter projects to facilitate scaling and modularized testing.',
      date: 'June 14, 2026',
      readTime: '6 min read',
      url: 'https://medium.com/@okama/mastering-clean-architecture-flutter-web',
      tags: ['Flutter', 'Clean Architecture', 'Web'],
    ),
    BlogPost(
      id: 'blog_2',
      title: 'Efficient State Management: BLoC vs Riverpod',
      summary: 'Comparing Bloc and Riverpod under production pressure. Why we chose Bloc for Bucapay fintech operations and how it structures complex state logic.',
      date: 'April 22, 2026',
      readTime: '8 min read',
      url: 'https://medium.com/@okama/bloc-vs-riverpod-production-comparison',
      tags: ['Bloc', 'Riverpod', 'State Management'],
    ),
    BlogPost(
      id: 'blog_3',
      title: 'Building Offline-First Apps with Hive and Secure Storage',
      summary: 'Step-by-step strategies to encrypt sensitive user credentials and cache REST responses to deliver seamless mobile layouts without active internet.',
      date: 'Jan 09, 2026',
      readTime: '5 min read',
      url: 'https://medium.com/@okama/offline-first-flutter-hive-secure-storage',
      tags: ['Security', 'Hive', 'Offline Sync'],
    ),
  ];

  static const List<String> testimonials = [
    'Okwuchukwu is a world-class Flutter developer. He rebuilt our crypto wallet interface under a tight schedule, improving transaction completion rates by 22%. He communicates exceptionally well and understands Clean Architecture at a deep level.',
    'Working with Okwuchukwu was a absolute pleasure. His work on J.Community demonstrated masterly level execution of offline synchronization, QR check-ins, and complex map integrations. Highly recommended for any senior mobile project.',
    'A highly analytical and dedicated professional. Okwuchukwu is excellent at setting up architectural principles that help scaling teams. His expertise in Bloc and Flutter Web animations sets him apart.',
  ];
}
