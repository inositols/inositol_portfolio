import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/spotlight_card.dart';

class TestimonialSection extends StatelessWidget {
  final List<String> testimonials;

  const TestimonialSection({super.key, required this.testimonials});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final names = ['Tunde Olanrewaju', 'Amara K. Onyeka', 'Kenji Tanaka'];
    final roles = ['CEO at BucaPay', 'Product Manager at J.Community', 'Tech Lead at Pouch Mobile'];
    final initials = ['TO', 'AO', 'KT'];

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
              "Client & Colleague Endorsements",
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
            "Here is what my clients, managers, and teammates say about working with me.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Grid list of testimonials
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 250,
            ),
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              final text = testimonials[index];
              final name = names[index];
              final role = roles[index];
              final init = initials[index];

              return SpotlightCard(
                borderRadius: 16,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quote marks & Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.format_quote_rounded,
                            color: AppColors.primary,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            text,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.5,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                              color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      // User Info Row
                      Row(
                        children: [
                          // Avatar Circle
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              init,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  role,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate(delay: (200 * index).ms).fadeIn(duration: 600.ms).scale();
            },
          ),
        ],
      ),
    );
  }
}
