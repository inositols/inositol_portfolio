import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double borderWidth;
  final Color? borderColor;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 12.0,
    this.borderWidth = 1.0,
    this.borderColor,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final fallbackColor = isDark 
        ? Colors.black.withValues(alpha: 0.4) 
        : Colors.white.withValues(alpha: 0.6);
    
    final fallbackBorderColor = isDark 
        ? Colors.white.withValues(alpha: 0.08) 
        : Colors.black.withValues(alpha: 0.08);

    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle 
            ? BorderRadius.zero 
            : (borderRadius ?? BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              shape: shape,
              color: color ?? fallbackColor,
              borderRadius: shape == BoxShape.circle 
                  ? null 
                  : (borderRadius ?? BorderRadius.circular(16)),
              border: Border.all(
                color: borderColor ?? fallbackBorderColor,
                width: borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
