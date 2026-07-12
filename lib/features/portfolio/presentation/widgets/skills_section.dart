import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/spotlight_card.dart';
import '../../data/models/portfolio_models.dart';

class SkillsSection extends StatelessWidget {
  // Keeping constructor signature to avoid breaking parent widgets, but using custom local data mapping
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_ExpertiseData> expertiseList = [
      _ExpertiseData(
        name: 'Flutter',
        icon: Icons.flutter_dash_rounded,
        years: 4,
        confidence: 0.98,
        glowColor: Colors.blueAccent,
        explanation: 'Architecting modular cross-platform apps using high-fidelity rendering, native platform channels, and adaptive layouts.',
        projects: ['J.Community', 'BucaPay', 'Monami', 'Health Log'],
      ),
      _ExpertiseData(
        name: 'Firebase',
        icon: Icons.local_fire_department_rounded,
        years: 4,
        confidence: 0.92,
        glowColor: Colors.orangeAccent,
        explanation: 'Deploying secure Cloud Firestore structures, Firebase Auth rules, FCM notifications, and serverless Cloud Functions.',
        projects: ['J.Community', 'Monami'],
      ),
      _ExpertiseData(
        name: 'Bloc',
        icon: Icons.loop_rounded,
        years: 4,
        confidence: 0.98,
        glowColor: Colors.cyanAccent,
        explanation: 'Decoupling event-driven states from user layouts. Ensuring highly predictable data streams and testing isolation.',
        projects: ['J.Community', 'BucaPay', 'Health Log'],
      ),
      _ExpertiseData(
        name: 'Clean Architecture',
        icon: Icons.layers_outlined,
        years: 4,
        confidence: 0.96,
        glowColor: Colors.purpleAccent,
        explanation: 'Separating codebases into isolated Domain, Data, and Presentation layers to support massive scaling and modular testing.',
        projects: ['J.Community', 'BucaPay'],
      ),
      _ExpertiseData(
        name: 'REST APIs',
        icon: Icons.settings_ethernet_rounded,
        years: 4,
        confidence: 0.95,
        glowColor: Colors.pinkAccent,
        explanation: 'Integrating secure, low-latency REST endpoints, token handshakes, JSON serialization, and automated error mapping.',
        projects: ['BucaPay', 'Monami'],
      ),
      _ExpertiseData(
        name: 'State Management',
        icon: Icons.schema_rounded,
        years: 4,
        confidence: 0.95,
        glowColor: Colors.indigoAccent,
        explanation: 'Directing complex layout bindings utilizing state structures like BLoC, Riverpod, and ChangeNotifier controllers.',
        projects: ['J.Community', 'BucaPay', 'Monami', 'Health Log'],
      ),
      _ExpertiseData(
        name: 'Performance Optimization',
        icon: Icons.speed_rounded,
        years: 4,
        confidence: 0.94,
        glowColor: Colors.amberAccent,
        explanation: 'Achieving 60/120fps frame rates with multi-threaded Isolates, custom painters, lazy-list rendering, and asset caching.',
        projects: ['BucaPay', 'Monami'],
      ),
      _ExpertiseData(
        name: 'Offline-first Apps',
        icon: Icons.cloud_off_rounded,
        years: 4,
        confidence: 0.95,
        glowColor: Colors.teal,
        explanation: 'Building local sync queues, Hive document indexing, secure DB encryption via SQLCipher, and offline-signed operations.',
        projects: ['J.Community', 'BucaPay', 'Health Log'],
      ),
      _ExpertiseData(
        name: 'Google Maps',
        icon: Icons.map_rounded,
        years: 3,
        confidence: 0.88,
        glowColor: Colors.redAccent,
        explanation: 'Implementing live user tracking, custom map styles, polygon search zoning, and optimized marker clustering.',
        projects: ['J.Community'],
      ),
      _ExpertiseData(
        name: 'Push Notifications',
        icon: Icons.notifications_active_rounded,
        years: 3,
        confidence: 0.90,
        glowColor: Colors.tealAccent,
        explanation: 'Delivering interactive background notifications, push payloads via FCM, and local scheduling handlers.',
        projects: ['J.Community', 'BucaPay'],
      ),
      _ExpertiseData(
        name: 'Payments',
        icon: Icons.credit_card_rounded,
        years: 3,
        confidence: 0.92,
        glowColor: Colors.lightGreenAccent,
        explanation: 'Integrating mobile card processing via Stripe SDK, web payment sessions, and secure crypto fiat payout mechanisms.',
        projects: ['BucaPay', 'Monami'],
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text(
              "Core Engineering Expertise",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Curated production experience across key tools, paradigms, and architectures used in building modern scalable applications.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Grid list of Expertise Cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 280,
            ),
            itemCount: expertiseList.length,
            itemBuilder: (context, index) {
              final exp = expertiseList[index];

              return SpotlightCard(
                borderRadius: 16,
                glowColor: exp.glowColor.withValues(alpha: 0.12),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Icon, Title, Years Pill
                      Row(
                        children: [
                          Icon(exp.icon, color: exp.glowColor, size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              exp.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: exp.glowColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: exp.glowColor.withValues(alpha: 0.2)),
                            ),
                            child: Text(
                              '${exp.years} Yrs',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: exp.glowColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Short Explanation text
                      Expanded(
                        child: Text(
                          exp.explanation,
                          style: TextStyle(
                            fontSize: 12.5,
                            height: 1.5,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Projects wrap
                      const Text(
                        'INTEGRATED IN:',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: exp.projects.map((proj) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Text(
                              proj,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Confidence Level Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'CONFIDENCE LEVEL',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            '${(exp.confidence * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: exp.glowColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Stack(
                        children: [
                          Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white10 : Colors.black12,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: exp.confidence,
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [exp.glowColor, exp.glowColor.withValues(alpha: 0.6)],
                                ),
                                borderRadius: BorderRadius.circular(2.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: exp.glowColor.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ).animate().scale(
                              begin: const Offset(0, 1),
                              end: const Offset(1, 1),
                              duration: 800.ms,
                              alignment: Alignment.centerLeft,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate(delay: (100 * index).ms).fadeIn(duration: 600.ms).slideY(begin: 0.05, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class _ExpertiseData {
  final String name;
  final IconData icon;
  final int years;
  final double confidence;
  final Color glowColor;
  final String explanation;
  final List<String> projects;

  _ExpertiseData({
    required this.name,
    required this.icon,
    required this.years,
    required this.confidence,
    required this.glowColor,
    required this.explanation,
    required this.projects,
  });
}
