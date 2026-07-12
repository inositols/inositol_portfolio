import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeonButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? glowColor;
  final List<Color>? gradientColors;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isSecondary;

  const NeonButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.glowColor,
    this.gradientColors,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.isSecondary = false,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Background and shadows
    final List<Color> activeGradients = widget.gradientColors ?? 
        (widget.isSecondary 
            ? [Colors.transparent, Colors.transparent] 
            : [AppColors.primary, AppColors.accent]);
            
    final Color buttonGlowColor = widget.glowColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: (_isHovered && !widget.isSecondary)
              ? [
                  BoxShadow(
                    color: buttonGlowColor.withValues(alpha: 0.4),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: widget.padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: widget.isSecondary 
                    ? Border.all(
                        color: _isHovered 
                            ? AppColors.primary 
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                        width: 1.5,
                      )
                    : Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1,
                      ),
                gradient: widget.isSecondary 
                    ? null 
                    : LinearGradient(
                        colors: activeGradients,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: widget.isSecondary 
                    ? (isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02))
                    : null,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
