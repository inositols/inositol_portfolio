import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/spotlight_card.dart';
import '../../data/models/portfolio_models.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Group skills by category
    final Map<String, List<Skill>> groupedSkills = {};
    for (var skill in skills) {
      groupedSkills.putIfAbsent(skill.category, () => []).add(skill);
    }

    final categories = ['Languages', 'Backend', 'Architecture', 'Tools'];
    final categoryIcons = {
      'Languages': Icons.translate_rounded,
      'Backend': Icons.dns_rounded,
      'Architecture': Icons.architecture_rounded,
      'Tools': Icons.construction_rounded,
    };

    final categoryColors = {
      'Languages': AppColors.primary,
      'Backend': AppColors.accent,
      'Architecture': Colors.purpleAccent,
      'Tools': Colors.orangeAccent,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text(
              "Skills & Tech Stack",
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
            "Here is the stack of languages, technologies, architectures, and tools that I specialize in.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Grid Layout
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 4),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 340,
            ),
            itemCount: categories.length,
            itemBuilder: (context, catIndex) {
              final cat = categories[catIndex];
              final catSkills = groupedSkills[cat] ?? [];
              final catIcon = categoryIcons[cat] ?? Icons.code_rounded;
              final catColor = categoryColors[cat] ?? AppColors.primary;

              return SpotlightCard(
                borderRadius: 16,
                glowColor: catColor.withValues(alpha: 0.12),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Icon(catIcon, color: catColor, size: 24),
                          const SizedBox(width: 12),
                          Text(
                            cat,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08)),
                      const SizedBox(height: 16),

                      // Skill indicators
                      Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: catSkills.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final skill = catSkills[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      skill.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${(skill.level * 100).toInt()}%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isDark ? Colors.white54 : Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                
                                // Progress bar
                                Stack(
                                  children: [
                                    Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: isDark 
                                            ? Colors.white.withValues(alpha: 0.05) 
                                            : Colors.black.withValues(alpha: 0.05),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: skill.level,
                                      child: Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [catColor, catColor.withValues(alpha: 0.6)],
                                          ),
                                          borderRadius: BorderRadius.circular(3),
                                          boxShadow: [
                                            BoxShadow(
                                              color: catColor.withValues(alpha: 0.3),
                                              blurRadius: 4,
                                              offset: const Offset(0, 1),
                                            )
                                          ]
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate(delay: (150 * catIndex).ms).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
            },
          ),
        ],
      ),
    );
  }
}
