import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/neon_button.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/utils/launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onHireMe;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onHireMe,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final double textScale = isMobile ? 0.8 : 1.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 80 : 120,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Hello Badge
          GlassContainer(
            blur: 8.0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: BorderRadius.circular(30),
            color: isDark 
                ? AppColors.primary.withValues(alpha: 0.1) 
                : AppColors.primary.withValues(alpha: 0.05),
            borderColor: AppColors.primary.withValues(alpha: 0.2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (controller) => controller.repeat())
                 .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 1000.ms, curve: Curves.easeOut)
                 .fadeOut(duration: 1000.ms),
                const SizedBox(width: 8),
                Text(
                  'Available for International Remote Roles',
                  style: TextStyle(
                    color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black.withValues(alpha: 0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).scale(delay: 100.ms),

          const SizedBox(height: 28),

          // Main Name
          Text(
            "Hi, I'm Okwuchukwu Okama",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48 * textScale,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              height: 1.1,
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.15, end: 0),

          const SizedBox(height: 16),

          // Hero Subtitle Gradient
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              "Senior Flutter Engineer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36 * textScale,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 350.ms).slideY(begin: 0.15, end: 0),

          const SizedBox(height: 24),

          // Description
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Text(
              "I build scalable, clean-architected cross-platform mobile applications using Flutter, Firebase, and modern software design patterns. Specialized in crafting smooth, offline-first production ecosystems.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16 * textScale,
                height: 1.6,
                fontWeight: FontWeight.w400,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 500.ms).slideY(begin: 0.15, end: 0),

          const SizedBox(height: 48),

          // Action Buttons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 16,
            children: [
              NeonButton(
                onPressed: onHireMe,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hire Me',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms, delay: 650.ms).slideY(begin: 0.2, end: 0),
              
              NeonButton(
                onPressed: onViewProjects,
                isSecondary: true,
                child: Text(
                  'View Projects',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms, delay: 750.ms).slideY(begin: 0.2, end: 0),

              NeonButton(
                onPressed: () {
                  Launcher.launchURL("https://github.com/okama-dev/resume/raw/main/resume.pdf");
                },
                isSecondary: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.download_rounded,
                      size: 16,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Download Resume',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms, delay: 850.ms).slideY(begin: 0.2, end: 0),
            ],
          ),
        ],
      ),
    );
  }
}
