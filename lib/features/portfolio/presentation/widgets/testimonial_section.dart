import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/spotlight_card.dart';

class TestimonialSection extends StatefulWidget {
  final List<String> testimonials;

  const TestimonialSection({super.key, required this.testimonials});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _autoPlayTimer;

  final List<String> names = ['Tunde Olanrewaju', 'Amara K. Onyeka', 'Kenji Tanaka'];
  final List<String> roles = ['CEO', 'Product Manager', 'Tech Lead'];
  final List<String> companies = ['BucaPay', 'J.Community', 'Pouch Mobile'];
  final List<String> initials = ['TO', 'AO', 'KT'];
  final List<int> ratings = [5, 5, 5];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (widget.testimonials.isEmpty) return;
      final int nextPage = (_currentPage + 1) % widget.testimonials.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _prevPage() {
    _autoPlayTimer?.cancel();
    final int prevPage = _currentPage == 0 ? widget.testimonials.length - 1 : _currentPage - 1;
    _pageController.animateToPage(
      prevPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
    _startAutoPlay();
  }

  void _nextPage() {
    _autoPlayTimer?.cancel();
    final int nextPage = (_currentPage + 1) % widget.testimonials.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
    _startAutoPlay();
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
          // Section Heading
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
            "Read what team leads, founders, and stakeholders say about my technical execution and delivery.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Slider & Navigation Stack
          Stack(
            alignment: Alignment.center,
            children: [
              // PageView Slider Container
              SizedBox(
                height: isMobile ? 320 : 260,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.testimonials.length,
                  itemBuilder: (context, index) {
                    final String text = widget.testimonials[index];
                    final String name = names[index];
                    final String role = roles[index];
                    final String company = companies[index];
                    final String init = initials[index];
                    final int rating = ratings[index];
                    final bool isCurrent = _currentPage == index;

                    return AnimatedScale(
                      scale: isCurrent ? 1.0 : 0.95,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: AnimatedOpacity(
                        opacity: isCurrent ? 1.0 : 0.4,
                        duration: const Duration(milliseconds: 400),
                        child: SpotlightCard(
                          borderRadius: 20,
                          glowColor: AppColors.primary.withValues(alpha: 0.08),
                          child: Padding(
                            padding: const EdgeInsets.all(28),
                            child: isMobile 
                                ? _buildMobileSlide(text, name, role, company, init, rating, isDark)
                                : _buildDesktopSlide(text, name, role, company, init, rating, isDark),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Desktop Navigation Arrows (Float on left/right outer boundaries)
              if (!isMobile) ...[
                Positioned(
                  left: 0,
                  child: FloatingArrowButton(
                    icon: Icons.chevron_left_rounded,
                    onPressed: _prevPage,
                    isDark: isDark,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: FloatingArrowButton(
                    icon: Icons.chevron_right_rounded,
                    onPressed: _nextPage,
                    isDark: isDark,
                  ),
                ),
              ]
            ],
          ),
          
          const SizedBox(height: 32),

          // Bottom Slide Indicators & Mobile Arrows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isMobile) ...[
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                  onPressed: _prevPage,
                ),
                const SizedBox(width: 24),
              ],
              
              // Dots indicators
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.testimonials.length, (index) {
                  final bool isCurrent = _currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isCurrent ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: isCurrent ? AppColors.primaryGradient : null,
                      color: isCurrent ? null : (isDark ? Colors.white24 : Colors.black12),
                    ),
                  );
                }),
              ),

              if (isMobile) ...[
                const SizedBox(width: 24),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onPressed: _nextPage,
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSlide(
    String text,
    String name,
    String role,
    String company,
    String init,
    int rating,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar section
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              alignment: Alignment.center,
              child: Text(
                init,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Star rating
            Row(
              children: List.generate(5, (starIdx) {
                return Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: starIdx < rating ? Colors.amber : Colors.grey.withValues(alpha: 0.3),
                );
              }),
            ),
          ],
        ),
        const SizedBox(width: 28),

        // Text quote & Metadata
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Large Quote symbol + Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.format_quote_rounded, color: AppColors.primary, size: 32),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Author tags
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '•',
                    style: TextStyle(color: isDark ? Colors.white30 : Colors.black38),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$role, ',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  Text(
                    company,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileSlide(
    String text,
    String name,
    String role,
    String company,
    String init,
    int rating,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Quote
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.format_quote_rounded, color: AppColors.primary, size: 24),
              const SizedBox(height: 4),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // User info row
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              alignment: Alignment.center,
              child: Text(
                init,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                  ),
                  Text(
                    '$role at $company',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            
            // Star rating on right
            Row(
              children: List.generate(5, (starIdx) {
                return Icon(
                  Icons.star_rounded,
                  size: 12,
                  color: starIdx < rating ? Colors.amber : Colors.grey.withValues(alpha: 0.3),
                );
              }),
            ),
          ],
        )
      ],
    );
  }
}

class FloatingArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const FloatingArrowButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      blur: 8.0,
      width: 44,
      height: 44,
      shape: BoxShape.circle,
      padding: EdgeInsets.zero,
      borderColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
      color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
      child: Center(
        child: IconButton(
          icon: Icon(icon, size: 24, color: isDark ? Colors.white70 : Colors.black87),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
