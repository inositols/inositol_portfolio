import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/neon_button.dart';
import '../../../../core/utils/responsive.dart';

class FloatingNavbar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabSelected;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final VoidCallback onHireMePressed;
  final VoidCallback onMenuPressed;

  const FloatingNavbar({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onHireMePressed,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final double navbarWidth = isMobile ? double.infinity : 900.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 24.0,
      ),
      child: GlassContainer(
        blur: 16.0,
        height: 64,
        width: navbarWidth,
        borderRadius: BorderRadius.circular(30),
        borderColor: isDarkMode 
            ? Colors.white.withValues(alpha: 0.1) 
            : Colors.black.withValues(alpha: 0.08),
        color: isDarkMode 
            ? Colors.black.withValues(alpha: 0.5) 
            : Colors.white.withValues(alpha: 0.6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: isMobile ? _buildMobileRow(context) : _buildDesktopRow(context),
      ),
    );
  }

  Widget _buildMobileRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brand Logo
        _buildLogo(),

        // Actions
        Row(
          children: [
            // Theme Toggle
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 20,
              ),
              onPressed: onThemeToggle,
            ),
            const SizedBox(width: 8),

            // Hamburger menu button
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: onMenuPressed,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDesktopRow(BuildContext context) {
    final List<String> navItems = [
      'Home',
      'About',
      'Skills',
      'Projects',
      'Experience',
      'Open Source',
      'Blog',
      'Contact'
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brand Logo
        _buildLogo(),

        // Navigation links in the middle
        Row(
          children: List.generate(navItems.length, (index) {
            final String label = navItems[index];
            final bool isActive = activeIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isActive ? FontWeight.bold : SystemMouseCursors.click == SystemMouseCursors.click ? FontWeight.w500 : FontWeight.w500,
                          color: isActive 
                              ? AppColors.primary 
                              : (isDarkMode ? Colors.white70 : Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Underline animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 2,
                        width: isActive ? 20 : 0,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),

        // CTA Buttons on the right
        Row(
          children: [
            // Theme Toggle
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 20,
              ),
              onPressed: onThemeToggle,
            ),
            const SizedBox(width: 12),

            // Hire Me Button
            NeonButton(
              onPressed: onHireMePressed,
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                'Hire Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            'Okwuchukwu.dev',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
