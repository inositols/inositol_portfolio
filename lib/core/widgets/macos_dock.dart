import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class DockItem {
  final IconData icon;
  final String label;
  final String tooltip;

  const DockItem({
    required this.icon,
    required this.label,
    required this.tooltip,
  });
}

class MacosDock extends StatefulWidget {
  final int activeIndex;
  final Function(int) onTabSelected;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const MacosDock({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<MacosDock> createState() => _MacosDockState();
}

class _MacosDockState extends State<MacosDock> {
  int? _hoveredIndex;

  final List<DockItem> _items = const [
    DockItem(icon: Icons.home_rounded, label: 'Hero', tooltip: 'Home'),
    DockItem(icon: Icons.person_rounded, label: 'About', tooltip: 'About Me'),
    DockItem(icon: Icons.psychology_rounded, label: 'Skills', tooltip: 'Skills'),
    DockItem(icon: Icons.code_rounded, label: 'Projects', tooltip: 'Projects'),
    DockItem(icon: Icons.work_rounded, label: 'Experience', tooltip: 'Experience'),
    DockItem(icon: Icons.terminal_rounded, label: 'Open Source', tooltip: 'Open Source'),
    DockItem(icon: Icons.article_rounded, label: 'Blog', tooltip: 'Blog'),
    DockItem(icon: Icons.mail_rounded, label: 'Contact', tooltip: 'Contact'),
  ];

  double _getScale(int index) {
    if (_hoveredIndex == null) return 1.0;
    
    int diff = (index - _hoveredIndex!).abs();
    if (diff == 0) return 1.35;
    if (diff == 1) return 1.18;
    if (diff == 2) return 1.06;
    return 1.0;
  }

  double _getTranslationY(int index) {
    if (_hoveredIndex == null) return 0.0;
    
    int diff = (index - _hoveredIndex!).abs();
    if (diff == 0) return -12.0;
    if (diff == 1) return -6.0;
    if (diff == 2) return -2.0;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return GlassContainer(
      blur: 16.0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: BorderRadius.circular(24),
      borderColor: isDark 
          ? Colors.white.withValues(alpha: 0.06) 
          : Colors.black.withValues(alpha: 0.06),
      color: isDark 
          ? Colors.black.withValues(alpha: 0.55) 
          : Colors.white.withValues(alpha: 0.65),
      boxShadow: [
        BoxShadow(
          color: isDark 
              ? Colors.black.withValues(alpha: 0.3) 
              : Colors.black.withValues(alpha: 0.08),
          blurRadius: 24,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        )
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nav items
          ...List.generate(_items.length, (index) {
            final item = _items[index];
            final bool isActive = widget.activeIndex == index;
            final double scale = _getScale(index);
            final double translationY = _getTranslationY(index);

            return MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = index),
              onExit: (_) => setState(() => _hoveredIndex = null),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => widget.onTabSelected(index),
                child: Tooltip(
                  message: item.tooltip,
                  verticalOffset: -55,
                  preferBelow: false,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  textStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Transform.translate(
                    offset: Offset(0, translationY),
                    child: Transform.scale(
                      scale: scale,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppColors.primary
                              : (isDark 
                                  ? Colors.white.withValues(alpha: 0.05) 
                                  : Colors.black.withValues(alpha: 0.04)),
                          border: Border.all(
                            color: isActive
                                ? AppColors.accent.withValues(alpha: 0.5)
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          item.icon,
                          color: isActive
                              ? Colors.white
                              : (isDark ? Colors.white.withValues(alpha: 0.8) : Colors.black.withValues(alpha: 0.8)),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),

          // Divider
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 28,
            width: 1,
            color: isDark ? Colors.white.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.12),
          ),

          // Theme Toggle item
          MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = _items.length),
            onExit: (_) => setState(() => _hoveredIndex = null),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onThemeToggle,
              child: Tooltip(
                message: isDark ? 'Light Mode' : 'Dark Mode',
                verticalOffset: -55,
                preferBelow: false,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    width: 1,
                  ),
                ),
                textStyle: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                child: Transform.translate(
                  offset: Offset(0, _getTranslationY(_items.length)),
                  child: Transform.scale(
                    scale: _getScale(_items.length),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark 
                            ? Colors.white.withValues(alpha: 0.05) 
                            : Colors.black.withValues(alpha: 0.04),
                      ),
                      child: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: isDark ? Colors.amber : Colors.indigo,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
