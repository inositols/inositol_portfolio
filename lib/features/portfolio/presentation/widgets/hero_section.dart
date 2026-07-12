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

    return Stack(
      alignment: Alignment.center,
      children: [
        // Premium Background floating blurred circles
        if (!isMobile) ...[
          // Primary Glow Blob (sinusoidal float left)
          Positioned(
            left: -100,
            top: 50,
            child:
                Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .move(
                      begin: const Offset(0, 0),
                      end: const Offset(40, 60),
                      duration: 8.seconds,
                      curve: Curves.easeInOutSine,
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                      duration: 8.seconds,
                      curve: Curves.easeInOutSine,
                    ),
          ),
          // Accent Glow Blob (sinusoidal float right)
          Positioned(
            right: -100,
            bottom: 50,
            child:
                Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .move(
                      begin: const Offset(0, 0),
                      end: const Offset(-50, -40),
                      duration: 10.seconds,
                      curve: Curves.easeInOutSine,
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.15, 1.15),
                      duration: 10.seconds,
                      curve: Curves.easeInOutSine,
                    ),
          ),
        ],

        // Hero Content Layout
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: isMobile ? 100 : 140,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Availability Badge with Green Pulse
              GlassContainer(
                blur: 12.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                borderRadius: BorderRadius.circular(30),
                color: isDark
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : AppColors.primary.withValues(alpha: 0.06),
                borderColor: AppColors.primary.withValues(alpha: 0.25),
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
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.7, 1.7),
                          duration: 1000.ms,
                          curve: Curves.easeOut,
                        )
                        .fadeOut(duration: 1000.ms),
                    const SizedBox(width: 8),
                    Text(
                      'Available for Remote Opportunities',
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.95)
                            : Colors.black.withValues(alpha: 0.85),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 100.ms),

              const SizedBox(height: 32),

              // 2. Primary Heading
              Text(
                    "Hi, I'm Okwuchukwu Okama",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 54 * textScale,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                      height: 1.1,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: 0.15, end: 0),

              const SizedBox(height: 16),

              // 3. Subheading with Shading Gradient
              ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: Text(
                      "Mobile Engineer (Flutter & Dart)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40 * textScale,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.8,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 350.ms)
                  .slideY(begin: 0.15, end: 0),

              const SizedBox(height: 24),

              // 4. Description Text Block
              ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      "I engineer robust, production-grade cross-platform apps utilizing Clean Architecture and the BLoC pattern. Specialized in crafting smooth, offline-first mobile ecosystems, secure fintech frameworks, and high-performance Web/Mobile integration.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17 * textScale,
                        height: 1.7,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 500.ms)
                  .slideY(begin: 0.15, end: 0),

              const SizedBox(height: 32),

              // Recruiter Quick Facts Dashboard
              GlassContainer(
                    blur: 16,
                    padding: const EdgeInsets.all(20),
                    borderRadius: BorderRadius.circular(16),
                    width: isMobile ? double.infinity : 860,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.02)
                        : Colors.black.withValues(alpha: 0.01),
                    borderColor: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.08),
                    child: isMobile
                        ? Column(
                            children: [
                              _buildFactItem(
                                'ROLE',
                                'Flutter Mobile Engineer',
                                Icons.phone_android_rounded,
                                isDark,
                              ),
                              const Divider(height: 20, color: Colors.white10),
                              _buildFactItem(
                                'EXPERIENCE',
                                '6+ Years Developer Practice',
                                Icons.calendar_today_rounded,
                                isDark,
                              ),
                              const Divider(height: 20, color: Colors.white10),
                              _buildFactItem(
                                'INDUSTRIES',
                                'FinTech • HealthTech • EventTech',
                                Icons.business_center_rounded,
                                isDark,
                              ),
                              const Divider(height: 20, color: Colors.white10),
                              _buildFactItem(
                                'CORE CAPABILITIES',
                                'Clean Architecture • Bloc • Offline-Sync',
                                Icons.architecture_rounded,
                                isDark,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _buildFactItem(
                                  'ROLE',
                                  'Flutter Mobile Engineer',
                                  Icons.phone_android_rounded,
                                  isDark,
                                ),
                              ),
                              _buildDivider(isDark),
                              Expanded(
                                child: _buildFactItem(
                                  'EXPERIENCE',
                                  '6+ Years Practice',
                                  Icons.calendar_today_rounded,
                                  isDark,
                                ),
                              ),
                              _buildDivider(isDark),
                              Expanded(
                                child: _buildFactItem(
                                  'INDUSTRIES',
                                  'FinTech • HealthTech • EventTech',
                                  Icons.business_center_rounded,
                                  isDark,
                                ),
                              ),
                              _buildDivider(isDark),
                              Expanded(
                                child: _buildFactItem(
                                  'KEY CAPABILITIES',
                                  'Clean Arc • Bloc • Offline-First',
                                  Icons.architecture_rounded,
                                  isDark,
                                ),
                              ),
                            ],
                          ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 580.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 36),

              // 5. Social Row
              _buildSocialRow(
                isDark,
              ).animate().fadeIn(duration: 800.ms, delay: 600.ms),

              const SizedBox(height: 48),

              // 6. Action Call-to-Buttons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 16,
                children: [
                  // Book a Call (Calendly/Contact jump)
                  NeonButton(
                        onPressed: onHireMe, // Scrolls to Contact Section
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Book a Call',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 650.ms)
                      .slideY(begin: 0.2, end: 0),

                  // View Projects
                  NeonButton(
                        onPressed: onViewProjects,
                        isSecondary: true,
                        child: Text(
                          'View Projects',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 750.ms)
                      .slideY(begin: 0.2, end: 0),

                  // Download Resume
                  NeonButton(
                        onPressed: () {
                          Launcher.launchURL(
                            "https://github.com/okama-dev/resume/raw/main/resume.pdf",
                          );
                        },
                        isSecondary: true,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.download_rounded,
                              size: 18,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Download Resume',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 850.ms)
                      .slideY(begin: 0.2, end: 0),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialRow(bool isDark) {
    final List<Map<String, dynamic>> socialLinks = [
      {
        'icon': Icons.code_rounded, // GitHub representation
        'tooltip': 'GitHub',
        'url': 'https://github.com/okama-dev',
      },
      {
        'icon': Icons.link_rounded, // LinkedIn representation
        'tooltip': 'LinkedIn',
        'url': 'https://linkedin.com/in/okwuchukwu-okama',
      },
      {
        'icon': Icons.email_outlined,
        'tooltip': 'Email',
        'url': 'mailto:okama.dev@gmail.com',
      },
      {
        'icon': Icons.chat_bubble_outline_rounded, // WhatsApp
        'tooltip': 'WhatsApp',
        'url': 'https://wa.me/2348123456789?text=Hi%20Okwuchukwu',
      },
    ];

    return Wrap(
      spacing: 16,
      children: socialLinks.map((item) {
        return Tooltip(
          message: item['tooltip'],
          child:
              MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ScaleTransition(
                      scale: const AlwaysStoppedAnimation(1.0),
                      child: GestureDetector(
                        onTap: () => Launcher.launchURL(item['url']),
                        child: GlassContainer(
                          blur: 8.0,
                          width: 44,
                          height: 44,
                          shape: BoxShape.circle,
                          padding: EdgeInsets.zero,
                          borderColor: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.08),
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.03)
                              : Colors.black.withValues(alpha: 0.03),
                          child: Center(
                            child: Icon(
                              item['icon'],
                              size: 20,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .moveY(
                    begin: 0,
                    end: -4,
                    duration: 2.seconds + (100 * socialLinks.indexOf(item)).ms,
                    curve: Curves.easeInOut,
                  ),
        );
      }).toList(),
    );
  }

  Widget _buildFactItem(
    String label,
    String value,
    IconData icon,
    bool isDark,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.accent, size: 18),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 32,
      width: 1,
      color: isDark ? Colors.white12 : Colors.black12,
    );
  }
}
