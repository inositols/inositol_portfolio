import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/neon_button.dart';
import '../../../../core/utils/launcher.dart';
import '../../data/models/portfolio_models.dart';

class ExperienceSection extends StatefulWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  final Set<String> _expandedIds = {};

  List<String> _getTechStackForExp(String id) {
    switch (id) {
      case 'bucapay_exp':
        return ['Flutter', 'Bloc', 'Clean Architecture', 'WebSockets', 'Hive', 'Biometrics'];
      case 'getpouch_exp':
        return ['Flutter', 'Stripe Integration', 'Hive', 'Firebase FCM', 'iOS & Android'];
      case 'jejelove_exp':
        return ['Flutter', 'Firestore', 'Realtime DB', 'Firebase Auth', 'Integration Tests'];
      case 'kleiba_exp':
        return ['PHP (Laravel)', 'Python (Django)', 'PostgreSQL', 'HTML5 & CSS3', 'JavaScript'];
      default:
        return ['Flutter', 'Dart'];
    }
  }

  @override
  void initState() {
    super.initState();
    // Pre-expand the first experience by default
    if (widget.experiences.isNotEmpty) {
      _expandedIds.add(widget.experiences.first.id);
    }
  }

  void _toggleExpanded(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              "Career Journey",
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
            "An interactive timeline highlighting my professional growth and corporate milestones.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 56),

          // Vertical Timeline Stack
          Stack(
            children: [
              // Continuous timeline line (offset values based on layout)
              Positioned(
                left: isMobile ? 18 : 200,
                top: 24,
                bottom: 24,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.accent.withValues(alpha: 0.5),
                        Colors.purple.withValues(alpha: 0.2),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Timeline items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.experiences.length,
                itemBuilder: (context, index) {
                  final exp = widget.experiences[index];
                  final bool isExpanded = _expandedIds.contains(exp.id);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Year (hidden or positioned differently on Mobile)
                        if (!isMobile)
                          SizedBox(
                            width: 170,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    exp.period,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.accent,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    exp.location,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Center Dot
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            left: isMobile ? 8 : 0,
                            right: isMobile ? 24 : 32,
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => _toggleExpanded(exp.id),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.bgDark : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isExpanded ? AppColors.accent : AppColors.primary,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (isExpanded ? AppColors.accent : AppColors.primary).withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Right Column: Experience Glass Container card
                        Expanded(
                          child: InkWell(
                            onTap: () => _toggleExpanded(exp.id),
                            borderRadius: BorderRadius.circular(16),
                            child: GlassContainer(
                              blur: 10.0,
                              padding: const EdgeInsets.all(24),
                              color: isDark 
                                  ? Colors.white.withValues(alpha: isExpanded ? 0.05 : 0.02) 
                                  : Colors.black.withValues(alpha: isExpanded ? 0.04 : 0.01),
                              borderColor: isExpanded 
                                  ? AppColors.primary.withValues(alpha: 0.3) 
                                  : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Period & Location on Mobile inside the card
                                  if (isMobile) ...[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          exp.period,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                        Text(
                                          exp.location,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              exp.role,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              exp.company,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        isExpanded 
                                            ? Icons.keyboard_arrow_up_rounded 
                                            : Icons.keyboard_arrow_down_rounded,
                                        color: isDark ? Colors.white54 : Colors.black54,
                                      ),
                                    ],
                                  ),

                                  // Expanded Content (using AnimatedSize)
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    alignment: Alignment.topCenter,
                                    child: isExpanded
                                        ? Container(
                                            margin: const EdgeInsets.only(top: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Divider(height: 1, color: Colors.white10),
                                                const SizedBox(height: 16),
                                                ...exp.responsibilities.map((resp) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(bottom: 12),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(top: 6, right: 12),
                                                          child: Icon(
                                                            Icons.circle_rounded,
                                                            size: 6,
                                                            color: AppColors.primary,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            resp,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              height: 1.5,
                                                              color: isDark ? Colors.white.withValues(alpha: 0.8) : Colors.black87,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                const SizedBox(height: 16),
                                                Text(
                                                  'Technologies Used:',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: isDark ? Colors.white70 : Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Wrap(
                                                  spacing: 6,
                                                  runSpacing: 6,
                                                  children: _getTechStackForExp(exp.id).map((tech) {
                                                    return Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.primary.withValues(alpha: 0.05),
                                                        borderRadius: BorderRadius.circular(12),
                                                        border: Border.all(
                                                          color: AppColors.primary.withValues(alpha: 0.15),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        tech,
                                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                if (exp.companyUrl.isNotEmpty) ...[
                                                  const SizedBox(height: 20),
                                                  NeonButton(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                    onPressed: () => Launcher.launchURL(exp.companyUrl),
                                                    isSecondary: true,
                                                    borderRadius: 8,
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(Icons.link_rounded, size: 14),
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          'Visit ${exp.company}',
                                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: (200 * index).ms).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
