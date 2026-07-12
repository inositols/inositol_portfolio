import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/spotlight_card.dart';

class CurrentlyBuildingSection extends StatelessWidget {
  const CurrentlyBuildingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_FocusItem> focusItems = [
      _FocusItem(
        title: 'Flutter Package Development',
        icon: Icons.inventory_2_outlined,
        color: Colors.blueAccent,
        progress: 0.85,
        description: 'Publishing and maintaining customized Dart packages for lightweight state handling and high-fidelity layout utilities.',
      ),
      _FocusItem(
        title: 'AI-powered Mobile Applications',
        icon: Icons.psychology_outlined,
        color: Colors.purpleAccent,
        progress: 0.60,
        description: 'Integrating on-device vector models and local inference clients directly inside mobile layouts for private user analysis.',
      ),
      _FocusItem(
        title: 'Scalable Firebase Systems',
        icon: Icons.local_fire_department_outlined,
        color: Colors.orangeAccent,
        progress: 0.70,
        description: 'Automating multi-tenant security rules deployments and optimizing backend event listeners via serverless Cloud Functions.',
      ),
      _FocusItem(
        title: 'Cross-platform Performance',
        icon: Icons.speed_rounded,
        color: Colors.redAccent,
        progress: 0.90,
        description: 'Auditing image cache engines, rendering isolates, and layout rebuilding cycles to lock a solid 120 FPS on all targets.',
      ),
      _FocusItem(
        title: 'Offline-first Architecture',
        icon: Icons.cloud_off_rounded,
        color: Colors.teal,
        progress: 0.75,
        description: 'Refactoring transaction-sync wrappers to resolve schema conflicts and synchronize local Hive files securely.',
      ),
      _FocusItem(
        title: 'Modern Flutter UI Shaders',
        icon: Icons.brush_outlined,
        color: Colors.pinkAccent,
        progress: 0.50,
        description: 'Exploring custom GLSL shaders, complex canvas drawing painters, and customized physics parameters for responsive layout docks.',
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
              "Currently Building",
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
            "An inside look into the packages, features, and optimization systems I am actively developing right now.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Items Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 220,
            ),
            itemCount: focusItems.length,
            itemBuilder: (context, index) {
              final item = focusItems[index];

              return SpotlightCard(
                borderRadius: 16,
                glowColor: item.color.withValues(alpha: 0.12),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Icon + Title
                      Row(
                        children: [
                          Icon(item.icon, color: item.color, size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Description
                      Expanded(
                        child: Text(
                          item.description,
                          style: TextStyle(
                            fontSize: 12.5,
                            height: 1.5,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Progress status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                              ).animate(onPlay: (c) => c.repeat())
                               .scale(begin: const Offset(1, 1), end: const Offset(1.6, 1.6), duration: 1000.ms)
                               .fadeOut(duration: 1000.ms),
                              const SizedBox(width: 8),
                              const Text(
                                'Active Build',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${(item.progress * 100).toInt()}% Done',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: item.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Progress bar
                      Stack(
                        children: [
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white10 : Colors.black12,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: item.progress,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: item.color,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate(delay: (80 * index).ms).fadeIn(duration: 600.ms).slideY(begin: 0.05, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class _FocusItem {
  final String title;
  final IconData icon;
  final Color color;
  final double progress;
  final String description;

  _FocusItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.progress,
    required this.description,
  });
}
