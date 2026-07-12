import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/utils/launcher.dart';

class ExpandingFab extends StatefulWidget {
  const ExpandingFab({super.key});

  @override
  State<ExpandingFab> createState() => _ExpandingFabState();
}

class _ExpandingFabState extends State<ExpandingFab> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.download_rounded,
        'tooltip': 'Download Resume',
        'url': 'https://github.com/okama-dev/resume/raw/main/resume.pdf',
        'color': Colors.amberAccent,
      },
      {
        'icon': Icons.code_rounded,
        'tooltip': 'GitHub',
        'url': 'https://github.com/okama-dev',
        'color': Colors.purpleAccent,
      },
      {
        'icon': Icons.link_rounded,
        'tooltip': 'LinkedIn',
        'url': 'https://linkedin.com/in/okwuchukwu-okama',
        'color': Colors.blueAccent,
      },
      {
        'icon': Icons.chat_bubble_outline_rounded,
        'tooltip': 'WhatsApp',
        'url': 'https://wa.me/2348123456789?text=Hi%20Okwuchukwu',
        'color': AppColors.success,
      },
      {
        'icon': Icons.email_outlined,
        'tooltip': 'Email',
        'url': 'mailto:okama.dev@gmail.com',
        'color': AppColors.accent,
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Options List (Staggered Vertical popups)
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Column(
            children: menuItems.map((item) {
              final double indexOffset = menuItems.indexOf(item).toDouble();
              return AnimatedBuilder(
                animation: _expandAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0.0, (1.0 - _expandAnimation.value) * 15 * (5 - indexOffset)),
                    child: Opacity(
                      opacity: _expandAnimation.value,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, right: 4.0),
                        child: Tooltip(
                          message: item['tooltip'],
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Launcher.launchURL(item['url']);
                                _toggle(); // Auto-close
                              },
                              child: GlassContainer(
                                blur: 12.0,
                                width: 42,
                                height: 42,
                                shape: BoxShape.circle,
                                padding: EdgeInsets.zero,
                                borderColor: isDark 
                                    ? Colors.white.withValues(alpha: 0.1) 
                                    : Colors.black.withValues(alpha: 0.08),
                                color: isDark 
                                    ? Colors.black.withValues(alpha: 0.7) 
                                    : Colors.white.withValues(alpha: 0.7),
                                child: Center(
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 18,
                                    color: isDark ? Colors.white70 : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),

        // Main Toggle FAB Button
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _toggle,
            child: GlassContainer(
              blur: 16.0,
              width: 52,
              height: 52,
              shape: BoxShape.circle,
              padding: EdgeInsets.zero,
              borderColor: isDark 
                  ? AppColors.primary.withValues(alpha: 0.3) 
                  : AppColors.primary.withValues(alpha: 0.2),
              color: isDark 
                  ? AppColors.primary.withValues(alpha: 0.25) 
                  : AppColors.primary.withValues(alpha: 0.15),
              child: Center(
                child: RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: 0.125).animate(_expandAnimation), // 45 degree turn
                  child: Icon(
                    _isOpen ? Icons.add_rounded : Icons.connect_without_contact_rounded,
                    size: 24,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
