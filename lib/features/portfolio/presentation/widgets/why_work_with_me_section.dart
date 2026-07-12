import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/spotlight_card.dart';

class WhyWorkWithMeSection extends StatelessWidget {
  const WhyWorkWithMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_HireReason> reasons = [
      _HireReason(
        title: 'Production Flutter Experience',
        icon: Icons.check_circle_rounded,
        iconColor: AppColors.primary,
        description:
            '4+ years of building store-ready, production-grade applications that scale seamlessly across iOS, Android, and Web.',
      ),
      _HireReason(
        title: 'Clean Architecture Expert',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.purpleAccent,
        description:
            'Decoupled systems separating Domain, Data, and Presentation layers for highly testable codebases and isolated features.',
      ),
      _HireReason(
        title: 'Firebase Specialist',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.orangeAccent,
        description:
            'Designing secure Cloud Firestore schemas, complex Firebase security rules, and serverless background Cloud Functions.',
      ),
      _HireReason(
        title: 'Pixel-perfect UI Designer',
        icon: Icons.check_circle_rounded,
        iconColor: AppColors.accent,
        description:
            'Creating high-fidelity user layouts crafted with smooth micro-animations, custom paint canvas, and full responsive scales.',
      ),
      _HireReason(
        title: 'FinTech Engineering',
        icon: Icons.check_circle_rounded,
        iconColor: AppColors.success,
        description:
            'Building secure cryptocurrency off-ramping channels, biometrics verification flows, and network idempotency headers.',
      ),
      _HireReason(
        title: 'Event management ecosystems',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.tealAccent,
        description:
            'Architecting local scan-validation queues, check-in algorithms, offline databases, and automated certificate distribution.',
      ),
      _HireReason(
        title: 'Healthcare Applications',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.pinkAccent,
        description:
            'Writing local encrypted database layers using SQLCipher to store private vital logs, medical metrics, and on-device ML.',
      ),
      _HireReason(
        title: 'Offline-first Development',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.lightGreenAccent,
        description:
            'Integrating resilient caching queue layers, Hive document database indexes, and automated synchronization backends.',
      ),
      _HireReason(
        title: 'Secure Authentication',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.redAccent,
        description:
            'Enforcing biometric logs, hardware-backed keystore vaults, API token rotations, and encrypted token structures.',
      ),
      _HireReason(
        title: 'Performance Optimization',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.yellowAccent,
        description:
            'Decoupling heavy calculations into Isolates, caching images, and optimizing layout rebuild cycles to lock 60/120 FPS.',
      ),
      _HireReason(
        title: 'Strong Communication',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.indigoAccent,
        description:
            'Establishing transparent workflows, clear documentation, detailed code review guides, and close stakeholder alignments.',
      ),
      _HireReason(
        title: 'Fast & Reliable Delivery',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.deepPurpleAccent,
        description:
            'Quick prototyping, strict focus on modular reusability, and automated CI/CD releases to drive product feedback loops.',
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
          // Section Title
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text(
              "Why Companies Hire Me",
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
            "I solve real business challenges, optimize mobile app operations, and set high-caliber engineering patterns.",
            style: TextStyle(
              fontSize: 16,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Reasons Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile
                  ? 1
                  : (ResponsiveLayout.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 180,
            ),
            itemCount: reasons.length,
            itemBuilder: (context, index) {
              final reason = reasons[index];

              return SpotlightCard(
                    borderRadius: 16,
                    glowColor: reason.iconColor.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                reason.icon,
                                color: reason.iconColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  reason.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Text(
                              reason.description,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.5,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .animate(delay: (60 * index).ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.05, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class _HireReason {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String description;

  _HireReason({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.description,
  });
}
