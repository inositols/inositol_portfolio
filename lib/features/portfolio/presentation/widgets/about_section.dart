import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/spotlight_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<String> keywords = [
      'Flutter',
      'Firebase',
      'Clean Architecture',
      'BLoC',
      'Riverpod',
      'REST APIs',
      'Offline-first apps',
      'Google Maps',
      'Push Notifications',
      'Payment Integration',
    ];

    // Left bio description + tag list
    final bioColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            "About Me",
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
          "I am a results-driven Senior Flutter Engineer with a passion for designing reliable architecture and high-performance cross-platform interfaces. Over the past 6+ years, I have built mobile and web apps across fintech, e-commerce, and logistics, collaborating with distributed teams globally.",
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "I focus heavily on clean-code practices, applying SOLID principles and decoupling systems so that development is modular, testable, and rapidly scalable. I love pushing the boundaries of what is possible on the canvas, building micro-interactions and animations that feel responsive and premium.",
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "Core Competencies",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(keywords.length, (index) {
            final key = keywords[index];
            return GlassContainer(
              blur: 6.0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              borderRadius: BorderRadius.circular(20),
              color: isDark 
                  ? Colors.white.withValues(alpha: 0.03) 
                  : Colors.black.withValues(alpha: 0.03),
              borderColor: isDark 
                  ? Colors.white.withValues(alpha: 0.08) 
                  : Colors.black.withValues(alpha: 0.08),
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black.withValues(alpha: 0.9),
                ),
              ),
            ).animate(delay: (50 * index).ms).fadeIn(duration: 400.ms).scale();
          }),
        ),
      ],
    );

    // Right graphic editor mockup (Dart Class representing Okama)
    final profileCard = Center(
      child: SpotlightCard(
        borderRadius: 16,
        glowColor: AppColors.accent.withValues(alpha: 0.12),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F0F13) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mock Editor Header
              Row(
                children: [
                  Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                  const Expanded(child: SizedBox()),
                  Text(
                    'engineer.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.white10),
              
              // Code Content
              _codeLine(1, "class FlutterEngineer {", Colors.purpleAccent, isDark),
              _codeLine(2, "  final String name = 'Okwuchukwu Okama';", Colors.cyanAccent, isDark),
              _codeLine(3, "  final String role = 'Senior Flutter Developer';", Colors.cyanAccent, isDark),
              _codeLine(4, "  final List<String> focus = [", Colors.amberAccent, isDark),
              _codeLine(5, "    'Clean Architecture', 'Bloc', 'Fintech'", Colors.greenAccent, isDark),
              _codeLine(6, "  ];", Colors.amberAccent, isDark),
              _codeLine(7, "  final bool likesInternationalRemote = true;", Colors.orangeAccent, isDark),
              _codeLine(8, "  final double coffeeLevel = 1.0; // Fully charged", Colors.grey, isDark),
              _codeLine(9, "  ", Colors.white, isDark),
              _codeLine(10, "  void code() {", Colors.purpleAccent, isDark),
              _codeLine(11, "    while (inspired) {", Colors.purpleAccent, isDark),
              _codeLine(12, "      createStunningApps();", Colors.blueAccent, isDark),
              _codeLine(13, "      optimizePerformance();", Colors.blueAccent, isDark),
              _codeLine(14, "    }", Colors.purpleAccent, isDark),
              _codeLine(15, "  }", Colors.purpleAccent, isDark),
              _codeLine(16, "}", Colors.purpleAccent, isDark),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 300.ms).slideX(begin: 0.1, end: 0);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bioColumn,
                const SizedBox(height: 48),
                profileCard,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: bioColumn),
                const SizedBox(width: 48),
                Expanded(flex: 4, child: profileCard),
              ],
            ),
    );
  }

  Widget _codeLine(int lineNum, String content, Color highlightColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              "$lineNum",
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: isDark ? Colors.white24 : Colors.black26,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: isDark ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
