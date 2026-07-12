import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpotlightCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final Color? glowColor;
  final VoidCallback? onTap;

  const SpotlightCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.glowColor,
    this.onTap,
  });

  @override
  State<SpotlightCard> createState() => _SpotlightCardState();
}

class _SpotlightCardState extends State<SpotlightCard> with SingleTickerProviderStateMixin {
  Offset _localOffset = Offset.zero;
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultGlowColor = widget.glowColor ?? AppColors.primary.withValues(alpha: 0.15);
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final cardBgColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        _controller.reverse();
      },
      onHover: (event) {
        setState(() {
          _localOffset = event.localPosition;
        });
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered 
                  ? AppColors.primary.withValues(alpha: 0.4) 
                  : borderColor,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Stack(
              children: [
                // Base background color
                Container(
                  color: cardBgColor,
                ),
                // Glowing radial spotlight overlay
                if (_isHovered)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: SpotlightPainter(
                        offset: _localOffset,
                        color: defaultGlowColor,
                      ),
                    ),
                  ),
                // The actual content
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpotlightPainter extends CustomPainter {
  final Offset offset;
  final Color color;

  SpotlightPainter({required this.offset, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, Colors.transparent],
        radius: 0.6,
      ).createShader(
        Rect.fromCircle(center: offset, radius: size.shortestSide * 0.8),
      );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant SpotlightPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.color != color;
  }
}
