import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/portfolio_models.dart';

class ProjectDetailsModal extends StatelessWidget {
  final Project project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final caseStudy = _getCaseStudyData(project.id);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12.0 : 48.0,
        vertical: 24.0,
      ),
      child: GlassContainer(
        blur: 24.0,
        width: isMobile ? double.infinity : 960.0,
        height: size.height * 0.85,
        borderRadius: BorderRadius.circular(24),
        borderColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
        color: isDark ? const Color(0xEC09090B) : const Color(0xECFAFAFB),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.accent : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(height: 32, color: Colors.white10),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Layout: Split layout on Desktop, Stack on Mobile
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildMetaDetails(isDark),
                              const SizedBox(height: 24),
                              _buildMainContent(caseStudy, isDark),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildMetaDetails(isDark)),
                              const SizedBox(width: 32),
                              Expanded(flex: 7, child: _buildMainContent(caseStudy, isDark)),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaDetails(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role Badge
        _buildMetaBlock(
          'MY ROLE',
          Text(
            project.role,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),

        // Category Badge
        _buildMetaBlock(
          'PLATFORM CATEGORY',
          Text(
            project.category,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),

        // Technologies Chips
        _buildMetaBlock(
          'CORE STACK',
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Accomplishments Chips
        _buildMetaBlock(
          'KEY FEATURES',
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.features.map((feat) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
                ),
                child: Text(
                  feat,
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.accent),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaBlock(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }

  Widget _buildMainContent(_CaseStudyData data, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Business Background & Problem statement
        _buildSectionHeader('Overview & Background'),
        _buildParagraph(data.background),
        const SizedBox(height: 24),

        _buildSectionHeader('The Problem'),
        _buildParagraph(data.problem),
        const SizedBox(height: 24),

        // Solution
        _buildSectionHeader('The Solution'),
        _buildParagraph(data.solution),
        const SizedBox(height: 24),

        // Architecture Deep Dive
        _buildSectionHeader('Architecture & Code Design'),
        _buildParagraph(data.architecture),
        const SizedBox(height: 24),

        // Technical Decisions or Challenges
        _buildSectionHeader('Technical Challenges & Solutions'),
        _buildParagraph(data.challenges),
        const SizedBox(height: 24),

        // Business Impact & Metrics
        _buildSectionHeader('Business Impact & Results'),
        _buildParagraph(data.impact),
        const SizedBox(height: 24),

        // Lessons Learned
        _buildSectionHeader('Key Lessons Learned'),
        _buildParagraph(data.lessons),
        
        // Code snippet section (if available)
        if (data.codeSnippet.isNotEmpty) ...[
          const SizedBox(height: 32),
          _buildSectionHeader('Code Architecture Sample'),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0C0C0F) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                data.codeSnippet,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Colors.white70,
      ),
    );
  }

  _CaseStudyData _getCaseStudyData(String id) {
    switch (id) {
      case 'jcommunity':
        return _CaseStudyData(
          background: 'J.Community is a multi-tenant corporate and social ecosystem developed to manage massive volunteer efforts, ticketing channels, and certificate distributions for large communities and events.',
          problem: 'Venues with zero network coverage made it impossible to run normal real-time QR ticket validations and check-ins. Traditional methods resulted in sync delays, duplicate check-ins, and inaccurate volunteer time logs.',
          solution: 'Engineered an offline synchronization scanning engine using local Hive database partitions, matching transactions against cryptographically signed offline certificates. When network is restored, a background queue handles automatic synchronization without interrupting the client flow.',
          architecture: 'Built using Clean Architecture principles separating data layers, domain entities, and business logic presentation. State management is completely governed by flutter_bloc, separating scanner state, user accounts state, and local queue sync status.',
          challenges: 'Offline authentication and data synchronization integrity was the biggest challenge. This was solved by creating an indexed local transaction stack that timestamps and sequences offline validations, resolving write-conflicts at the Firestore database layer using serverless Firebase Cloud Functions.',
          impact: 'Reduced entry scanning processing time from 4.5 seconds to 120ms (a 97% optimization), eliminating venue queues. Managed and verified over 10,000 attendees across completely offline venues, with 100% data sync accuracy.',
          lessons: 'Always design complex web/mobile operations with an offline-first mindset. Local storage schema migrations require strict planning to prevent user data loss during app updates.',
          codeSnippet: '''// Offline sync manager queue schema
class SyncQueueManager {
  final Box<ScanTransaction> _offlineBox;
  bool _isSyncing = false;

  Future<void> queueTransaction(ScanTransaction tx) async {
    await _offlineBox.add(tx);
    triggerSyncProcess();
  }

  Future<void> triggerSyncProcess() async {
    if (_isSyncing || !await checkConnectivity()) return;
    _isSyncing = true;
    
    final transactions = _offlineBox.values.toList();
    for (var tx in transactions) {
      try {
        await _cloudFirestore.collection('scans').add(tx.toMap());
        await _offlineBox.delete(tx.key);
      } catch (e) {
        log('Sync conflict resolved: ' + e.toString());
      }
    }
    _isSyncing = false;
  }
}''',
        );
      case 'bucapay':
        return _CaseStudyData(
          background: 'BucaPay is a high-volume fintech off-ramp mobile platform processing automated bank transfers and cryptocurrency liquidations.',
          problem: 'Fintech portals must balance latency speeds with heavy security restrictions. Handling instant payout requests during peak network traffic caused double-payout loops and transaction timeouts.',
          solution: 'Implemented a hardware-backed biometrics authorization layer coupled with idempotent request headers to secure endpoints, routing transactions through distributed WebSocket listeners to feed instant token prices.',
          architecture: 'Adheres strictly to SOLID principles, using Dart repositories, local encrypted caching via Hive, and a structured BLoC layer to prevent UI re-draws during stream-fed websocket ticker updates.',
          challenges: 'Managing WebSocket connection stability over unreliable mobile cellular networks. Resolved by implementing an automated exponential backoff reconnect policy combined with local cache fallbacks.',
          impact: 'Successfully handled and secured over \$1.5 million in total monthly transactions, maintaining a zero double-payout rate and reducing network handshake latencies by 35%.',
          lessons: 'Idempotency and database transaction locking are critical when dealing with financial transactions. Never trust client-side computed token conversions.',
          codeSnippet: '''// WebSocket exponential backoff connection logic
void connectWithBackoff() {
  _socket = WebSocketChannel.connect(Uri.parse(apiEndpoint));
  _socket.stream.listen(
    (data) => handlePriceUpdate(data),
    onError: (e) {
      log('Socket Error, reconnecting...');
      Future.delayed(Duration(seconds: _reconnectDelay), () {
        _reconnectDelay = (_reconnectDelay * 2).clamp(1, 60);
        connectWithBackoff();
      });
    },
    onDone: () => attemptReconnect(),
  );
}''',
        );
      case 'monami':
        return _CaseStudyData(
          background: 'Monami is a next-generation consumer-facing e-commerce shopping experience featuring real-time product catalogs and Stripe checkouts.',
          problem: 'Heavy images and complex layout animations caused frame drops (jank) during scroll events on low-end mobile devices, leading to lower cart conversions.',
          solution: 'Optimized rendering performance by implementing lazy image loading, SVG asset caching, and delegating computational sorting algorithms to background Isolate threads.',
          architecture: 'Built using Riverpod for localized state management, ensuring widget trees only rebuild when individual properties change.',
          challenges: 'Synchronizing cart states across multiple app sessions. Solved by writing a local Hive sync listener and writing a clean remote database merge repository.',
          impact: 'Improved cart retention rate by 22%. Scroll actions achieved a continuous 60fps frame rate on baseline budget smartphones.',
          lessons: 'Image compression and responsive asset caching are key to maintaining professional UX on standard mobile data plans.',
          codeSnippet: '',
        );
      case 'healthlog':
        return _CaseStudyData(
          background: 'Health Log is a fully offline, private analytics utility enabling users to log and monitor their vitals over long periods.',
          problem: 'Standard database solutions leak data if committed directly. Users require 100% database privacy without cloud dependencies.',
          solution: 'Built an encrypted local database using SQFlite (SQLCipher) utilizing locally generated hardware keys stored in secure system keystores.',
          architecture: 'Offline-only MVVM structure. Business computations are isolated from UI controllers using standard Dart mixins.',
          challenges: 'Generating accessible yet fully responsive charts representing high-density data. Solved using Fl Chart custom builders.',
          impact: 'Achieved a 5-star rating on utility storefronts. Successfully protected all patient logs without a single server data leak.',
          lessons: 'Local secure databases require rigid encryption key cycles and robust device backup procedures.',
          codeSnippet: '',
        );
      default:
        return _CaseStudyData(
          background: 'A premium development project detailing high-quality programming patterns and software layout practices.',
          problem: 'Requirement for custom business features and polished layouts.',
          solution: 'Developed robust software modules following Clean Architecture and test-driven design guidelines.',
          architecture: 'Clean Architecture with BLoC patterns.',
          challenges: 'Integrating external API systems and handling network failure protocols.',
          impact: 'Provided professional software assets and robust deployment pipelines.',
          lessons: 'Consistent structure and robust tests improve long-term code scalability.',
          codeSnippet: '',
        );
    }
  }
}

class _CaseStudyData {
  final String background;
  final String problem;
  final String solution;
  final String architecture;
  final String challenges;
  final String impact;
  final String lessons;
  final String codeSnippet;

  _CaseStudyData({
    required this.background,
    required this.problem,
    required this.solution,
    required this.architecture,
    required this.challenges,
    required this.impact,
    required this.lessons,
    required this.codeSnippet,
  });
}
