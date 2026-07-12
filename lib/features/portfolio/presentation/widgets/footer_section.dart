import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final socialRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
          Icons.link_rounded,
          () => Launcher.launchURL('https://linkedin.com/in/okwuchukwu-okama'),
          isDark,
        ),
        _buildSocialIcon(
          Icons.code_rounded,
          () => Launcher.launchURL('https://github.com/inositols'),
          isDark,
        ),
        _buildSocialIcon(
          Icons.chat_bubble_outline_rounded,
          () => Launcher.launchWhatsApp(
            phone: '+2349164815270',
            text: 'Hi Okwuchukwu...',
          ),
          isDark,
        ),
        _buildSocialIcon(
          Icons.mail_outline_rounded,
          () => Launcher.launchEmail(
            email: 'okamainnocent2020@gmail.com',
            subject: 'Inquiry',
          ),
          isDark,
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 40,
      ),
      child: Column(
        children: [
          Divider(color: isDark ? Colors.white10 : Colors.black12),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: [
                    socialRow,
                    const SizedBox(height: 20),
                    _buildCopyright(isDark),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildCopyright(isDark), socialRow],
                ),
        ],
      ),
    );
  }

  Widget _buildCopyright(bool isDark) {
    return Text(
      '© ${DateTime.now().year} Okwuchukwu Okama. Built with Flutter Web. All rights reserved.',
      style: TextStyle(
        fontSize: 12,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onTap,
        style: IconButton.styleFrom(
          foregroundColor: isDark ? Colors.white70 : Colors.black87,
          hoverColor: AppColors.primary.withValues(alpha: 0.1),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.08),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
