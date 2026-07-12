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
      features: ['Offline-First Sync', 'QR Scanner Check-in', 'Certificate Generator', 'Push Notifications', 'Role Management', 'Analytics Dashboard'],
      role: 'Lead Flutter Developer',
      githubUrl: 'https://github.com/inositols/jcommunity',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.jcommunity.app',
      appStoreUrl: 'https://apps.apple.com/app/j-community/id123456789',
      liveDemoUrl: 'https://jcommunity.web.app',
      problemStatement: 'Event organizers were facing severe synchronization latency and ticket duplication in regions with poor network infrastructure. Traditional scanning tools required persistent live database handshakes, leading to gridlocked check-in queues and incorrect volunteer attendance logs.',
      roleDescription: 'As the Lead Flutter Developer, I spearheaded the complete mobile architecture. I designed the offline sync mechanics, established standard local database schema migrations, and optimized QR code scanning speeds.',
      architectureDescription: 'Built using Clean Architecture principles separating data layers, domain entities, and business logic. State management is completely governed by flutter_bloc, separating scanner feeds, account caches, and local transaction synchronization status.',
      challengesDescription: 'Ensuring absolute database integrity across multi-tenant offline devices without cloud coordination. Offline scans must validate user signatures securely, prevent double check-ins, and resolve timestamp versioning conflicts once network connectivity is restored.',
      solutionDescription: 'Engineered an offline-first check-in synchronization engine using Hive database partitions. We validated attendee tickets via cryptographically signed QR payloads, storing transactions in an indexed local queue. Synchronized records back to Firebase using Cloud Functions designed with transaction-locking APIs.',
      resultDescription: 'Reduced average entry scanning time from 4.5 seconds to 120ms (a 97% latency decrease). Successfully processed over 10,000 attendee check-ins across multiple completely offline venues with zero data loss or check-in duplicates.',
      lessonsLearned: 'Always design complex mobile apps with a network-failure paradigm. Local database schemas must be version-managed and highly isolated to prevent data corruption during automatic sync overrides.',
    ),
    Project(
      id: 'bucapay',
      title: 'BucaPay',
      subtitle: 'Crypto Off-ramp Platform',
      description: 'A premium, highly secure cryptocurrency off-ramp platform enabling users to convert crypto instantly into fiat currency with automated bank transfers, localized payment channels, and strict security compliance.',
      category: 'Mobile',
      technologies: ['Flutter', 'Bloc', 'REST API', 'WebSockets', 'Biometrics', 'Hive'],
      features: ['Secure Crypto Wallet', 'Instant Fiat Payouts', 'Automated KYC Verification', 'Real-time Tickers', 'Multi-factor Auth', 'Transaction Exports'],
      role: 'Flutter Mobile Engineer',
      githubUrl: 'https://github.com/inositols/bucapay',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.bucapay.app',
      appStoreUrl: 'https://apps.apple.com/app/bucapay/id987654321',
      liveDemoUrl: 'https://bucapay.com',
      problemStatement: 'High-volume crypto off-ramp operations demand extreme security without sacrificing transaction latency. Mobile clients faced high connection drops on standard networks, causing incomplete checkout sessions and double-payment attempts.',
      roleDescription: 'As the Flutter Mobile Engineer, I designed the cryptocurrency wallet interface, integrated multi-factor biometrics authentication, and implemented real-time price tickers using secure WebSocket connections.',
      architectureDescription: 'Adheres strictly to SOLID design patterns, decoupling state controllers from network client repositories. Utilizes the BLoC pattern to manage real-time ticker stream subscriptions, ensuring fluid UI rendering.',
      challengesDescription: 'Maintaining stable WebSocket connections over unstable mobile cellular networks while keeping price feeds accurate. Resolving race conditions where users tap "Off-ramp" during rapid price fluctuations.',
      solutionDescription: 'Created a resilient WebSocket reconnect pipeline using an automated exponential backoff algorithm and local caching. Implemented secure hardware cryptography bindings and secure storage to encrypt sensitive keys, alongside server-verified idempotency headers on transfer payloads.',
      resultDescription: 'Processed over \$1.5M in monthly transaction volume with zero double-payment errors. Achieved a 35% reduction in network handshakes, lowering client resource footprint and battery drain significantly.',
      lessonsLearned: 'Server-side transaction idempotency is the ultimate safeguard when handling financial payouts. Price tickers must be decoupled into independent isolates to protect UI thread performance.',
    ),
    Project(
      id: 'monami',
      title: 'Monami',
      subtitle: 'Next-Gen E-commerce App',
      description: 'A modern consumer-facing e-commerce shopping experience featuring real-time product catalogs, instant checkout options, payment gateways, custom animations, and automated shipping updates.',
      category: 'Mobile',
      technologies: ['Flutter', 'Riverpod', 'REST API', 'Stripe Integration', 'Hive', 'Lottie'],
      features: ['Dynamic Cart System', 'Stripe Payment Gateway', 'Multi-tenant Checkout', 'Order Status Tracking', 'Interactive Carousel', 'Offline Cache Sync'],
      role: 'Core Mobile Developer',
      githubUrl: 'https://github.com/inositols/monami',
      liveDemoUrl: 'https://monamishop.web.app',
      problemStatement: 'E-commerce users abandon shopping carts if pages drop frames or load slowly. Loading large product listings with high-density images caused heavy thread blockages and scroll stuttering on lower-end devices.',
      roleDescription: 'As the Core Mobile Developer, I architected the shopping cart engine, optimized image rendering layouts, and integrated the Stripe Payment Gateway SDK.',
      architectureDescription: 'Built using Riverpod for localized state management, ensuring individual product cards only rebuild when their select properties (like cart count) are updated.',
      challengesDescription: 'Resolving image loading stutters and heavy JSON parsing lags when importing massive external product catalogs onto the main thread.',
      solutionDescription: 'Implemented asynchronous JSON parsing using Dart background Isolates, set up aggressive memory and disk caching for product image assets, and structured lazy loading ListView lists.',
      resultDescription: 'Maintained a solid 60fps scrolling experience across low-end mobile devices, leading to a 22% increase in checkout cart conversion rates.',
      lessonsLearned: 'Asynchronous isolate threads are critical for background JSON deserialization. Image compression at the server level is key to smooth scrolling performance.',
    ),
    Project(
      id: 'healthlog',
      title: 'Health Log',
      subtitle: 'Personal Health Monitor',
      description: 'An offline-first, private health logging app that computes health markers, generates statistical charts, and offers personalized health suggestions via local machine learning models.',
      category: 'Mobile',
      technologies: ['Flutter', 'SQFlite', 'Bloc', 'Flutter Local Notifications', 'Fl Chart'],
      features: ['Blood Pressure Logger', 'Blood Sugar Tracker', 'BMI Calculator', 'Local Encrypted DB', 'Recurrent Reminders', 'AI Insights Report'],
      role: 'Solo Developer',
      githubUrl: 'https://github.com/inositols/healthlog',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.healthlog.app',
      problemStatement: 'Health log users require absolute privacy for sensitive vital stats, making cloud storage undesirable. However, presenting long-term data trends offline without server computations poses heavy graphing and local database challenges.',
      roleDescription: 'As the Solo Developer, I designed the database layer, created the custom analytical graphing interfaces, and implemented biometric authorization structures.',
      architectureDescription: 'Built on a modular MVVM architecture. The application is completely offline-first, relying on secure local disk structures and local analytics computations.',
      challengesDescription: 'Rendering highly responsive, interactive charts representing high-density vital records without lagging UI rendering cycles.',
      solutionDescription: 'Designed an encrypted database using SQFlite (SQLCipher) bound to device-specific keystore credentials. Developed custom paint builders around the Fl Chart framework to render fluid vital trendlines.',
      resultDescription: 'Secured a 5-star rating on storefronts for absolute privacy and zero data leaks. Enabled thousands of patients to securely monitor blood pressure and blood sugar offline.',
      lessonsLearned: 'On-device security requires strict management of cryptographic key storage and localized backups. Custom painters are highly efficient for complex rendering compared to stock widgets.',
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
      role: 'Flutter Engineer (Remote)',
      period: 'Nov 2025 - May 2026',
      location: 'Lagos, Nigeria (Remote)',
      companyUrl: 'https://bucapay.com',
      responsibilities: [
        'Co-developed and maintained the mobile cryptocurrency off-ramp platform using Clean Architecture and the BLoC state management pattern to ensure clear separation of concerns.',
        'Integrated hardware-backed secure storage, multi-factor biometric authentication (face/fingerprint validation), and dynamic screen obscuring to meet strict fintech security guidelines.',
        'Designed and optimized WebSocket connection listeners to stream real-time price tickers, implementing automatic connection reconnect strategies using exponential backoff.',
        'Managed secure client-side API integrations using REST endpoints, customized HTTP header interceptors, and server-verified payload idempotency keys.',
        'Conducted engineering code reviews and drafted Git style guidelines to ensure high standards of readability and formatting across team repositories.'
      ],
    ),
    Experience(
      id: 'jcommunity_exp',
      company: 'J.Community',
      role: 'Lead Flutter Engineer (Contract)',
      period: 'Oct 2025 - Mar 2026',
      location: 'Nigeria (Remote)',
      companyUrl: 'https://jcommunity.web.app',
      responsibilities: [
        'Spearheaded the design of a scalable event management mobile application supporting multi-role access panels for both organizations and volunteer attendees.',
        'Integrated a client-side PDF certification builder, enabling on-device generation of volunteer certificates and reducing administrative overhead.',
        'Engineered an offline-first local cache and secure storage layers using EncryptedSharedPreferences to safeguard authentication tokens and sensitive data.',
        'Developed a multi-language localization system (l10n) supporting English and French, expanding the app\'s accessible market reach.'
      ],
    ),
    Experience(
      id: 'getpouch_exp',
      company: 'GetPouch',
      role: 'Flutter Developer (Remote)',
      period: 'Jan 2023 - Mar 2023',
      location: 'Nairobi, Kenya (Remote)',
      companyUrl: 'https://getpouch.co',
      responsibilities: [
        'Collaborated within an agile team to develop a cross-platform fintech mobile wallet designed for children and parents.',
        'Implemented pixel-perfect user interface layouts from design specs using custom animations and responsive widgets.',
        'Refactored core wallet balance structures and parental control tracking workflows to stabilize application states.',
        'Integrated RESTful API connectors utilizing secure network configurations to process digital pocket-money transactions.'
      ],
    ),
    Experience(
      id: 'jejelove_exp',
      company: 'Jejelove',
      role: 'Flutter Developer',
      period: 'Jan 2020 - Dec 2022',
      location: 'Lagos, Nigeria (Hybrid)',
      companyUrl: 'https://jejelove.org',
      responsibilities: [
        'Built high-fidelity mobile user interfaces prioritizing micro-animations, screen scaling support, and accessibility guidelines.',
        'Configured in-app chat systems, real-time messaging updates, and multiplayer logic utilizing Cloud Firestore and Firebase Realtime Database.',
        'Developed automated widget and integration tests using Flutter\'s testing frameworks to streamline release regression checks.',
        'Addressed rendering thread blockages by optimizing image caching strategies and auditing widget rebuild cycles.'
      ],
    ),
    Experience(
      id: 'kleiba_exp',
      company: 'Kleiba Technologies',
      role: 'Software Developer Intern',
      period: 'Oct 2019 - Dec 2020',
      location: 'Enugu, Nigeria (Onsite)',
      companyUrl: 'https://kleiba.com',
      responsibilities: [
        'Developed fullstack features and admin tools utilizing PHP (Laravel) and Python (Django) to support backend web services.',
        'Constructed responsive web layout designs using HTML5, CSS3, and JavaScript to interface with database components.',
        'Maintained database integrity by writing structured SQL query scripts and implementing database schema migrations on PostgreSQL databases.',
        'Participated in weekly standups, sprint planning sessions, and code reviews in an agile engineering environment.'
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
