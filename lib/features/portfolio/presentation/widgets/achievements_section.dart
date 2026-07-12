import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> achievements = [
      {
        'value': 4,
        'suffix': '+',
        'label': 'Years Experience',
        'sub': 'Mobile App Dev',
        'icon': Icons.calendar_today_rounded,
        'color': AppColors.primary,
      },
      {
        'value': 8,
        'suffix': '+',
        'label': 'Apps Built',
        'sub': 'Store Published',
        'icon': Icons.cloud_done_rounded,
        'color': Colors.purpleAccent,
      },
      {
        'value': 12,
        'suffix': '+',
        'label': 'Projects Delivered',
        'sub': 'Corporate & Contract',
        'icon': Icons.check_circle_outline_rounded,
        'color': AppColors.accent,
      },
      {
        'value': 12,
        'suffix': '+',
        'label': 'Technologies',
        'sub': 'Frameworks & Tools',
        'icon': Icons.psychology_rounded,
        'color': Colors.pinkAccent,
      },
      {
        'value': 1,
        'suffix': '+',
        'label': 'Open Source Packages',
        'sub': 'Ecosystem Libraries',
        'icon': Icons.inventory_2_rounded,
        'color': Colors.orangeAccent,
      },
      {
        'value': 20,
        'suffix': '+',
        'label': 'GitHub Repos',
        'sub': 'Public & Collaborative',
        'icon': Icons.code_rounded,
        'color': AppColors.success,
      },
      {
        'value': 4,
        'suffix': '+',
        'label': 'Production Apps',
        'sub': 'FinTech & Enterprise',
        'icon': Icons.phone_android_rounded,
        'color': Colors.redAccent,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 60,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : (ResponsiveLayout.isTablet(context) ? 4 : 7),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 190,
        ),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final ach = achievements[index];
          final Color themeColor = ach['color'] as Color;

          return GlassContainer(
            blur: 10.0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.01),
            borderColor: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ach['icon'] as IconData,
                  color: themeColor,
                  size: 24,
                ),
                const SizedBox(height: 12),
                
                // Count up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedCounter(
                      target: ach['value'] as int,
                      suffix: ach['suffix'] as String,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                Text(
                  ach['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ach['sub'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ).animate(delay: (100 * index).ms).fadeIn(duration: 600.ms).scale();
        },
      ),
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int target;
  final String suffix;
  final Color color;

  const AnimatedCounter({
    super.key,
    required this.target,
    required this.suffix,
    required this.color,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _animation = Tween<double>(begin: 0, end: widget.target.toDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double val = _animation.value;
        String formattedVal;
        
        if (widget.target >= 1000) {
          // Format as 1.8k
          final double kVal = val / 1000.0;
          formattedVal = '${kVal.toStringAsFixed(1)}k';
        } else {
          formattedVal = '${val.toInt()}';
        }

        return Text(
          '$formattedVal${widget.suffix}',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: widget.color,
            letterSpacing: -0.5,
          ),
        );
      },
    );
  }
}
