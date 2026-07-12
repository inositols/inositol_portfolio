import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ParticleBackground extends StatefulWidget {
  final Widget? child;

  const ParticleBackground({super.key, this.child});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final List<GlowBlob> _blobs = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        _updateElements();
      })..repeat();

    // Initialize elements
    _initializeElements();
  }

  void _initializeElements() {
    // Create 35 particles
    for (int i = 0; i < 35; i++) {
      _particles.add(Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        speedX: (_random.nextDouble() - 0.5) * 0.0005,
        speedY: (_random.nextDouble() - 0.5) * 0.0005,
        size: _random.nextDouble() * 2.5 + 0.5,
        opacity: _random.nextDouble() * 0.4 + 0.1,
      ));
    }

    // Create 3 slow glow blobs (glowing gradient blobs)
    _blobs.add(GlowBlob(
      color: AppColors.primary.withValues(alpha: 0.08),
      x: 0.2,
      y: 0.3,
      radiusX: 0.35,
      radiusY: 0.35,
      speedX: 0.0002,
      speedY: 0.0001,
    ));
    _blobs.add(GlowBlob(
      color: AppColors.accent.withValues(alpha: 0.06),
      x: 0.8,
      y: 0.2,
      radiusX: 0.4,
      radiusY: 0.4,
      speedX: -0.0001,
      speedY: 0.0002,
    ));
    _blobs.add(GlowBlob(
      color: Colors.purple.withValues(alpha: 0.05),
      x: 0.5,
      y: 0.8,
      radiusX: 0.45,
      radiusY: 0.45,
      speedX: 0.00015,
      speedY: -0.00015,
    ));
  }

  void _updateElements() {
    setState(() {
      for (var p in _particles) {
        p.x += p.speedX;
        p.y += p.speedY;

        // Wrap around boundaries
        if (p.x < 0) p.x = 1.0;
        if (p.x > 1) p.x = 0.0;
        if (p.y < 0) p.y = 1.0;
        if (p.y > 1) p.y = 0.0;
      }

      for (var b in _blobs) {
        b.x += b.speedX;
        b.y += b.speedY;

        // Bounce off bounds
        if (b.x < 0.05 || b.x > 0.95) b.speedX = -b.speedX;
        if (b.y < 0.05 || b.y > 0.95) b.speedY = -b.speedY;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPainter(
              particles: _particles,
              blobs: _blobs,
              isDark: Theme.of(context).brightness == Brightness.dark,
            ),
          ),
        ),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class Particle {
  double x;
  double y;
  double speedX;
  double speedY;
  double size;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.size,
    required this.opacity,
  });
}

class GlowBlob {
  Color color;
  double x;
  double y;
  double radiusX;
  double radiusY;
  double speedX;
  double speedY;

  GlowBlob({
    required this.color,
    required this.x,
    required this.y,
    required this.radiusX,
    required this.radiusY,
    required this.speedX,
    required this.speedY,
  });
}

class BackgroundPainter extends CustomPainter {
  final List<Particle> particles;
  final List<GlowBlob> blobs;
  final bool isDark;

  BackgroundPainter({
    required this.particles,
    required this.blobs,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // 1. Draw glowing blobs (gradients)
    for (var blob in blobs) {
      final center = Offset(blob.x * size.width, blob.y * size.height);
      final radius = max(size.width, size.height) * max(blob.radiusX, blob.radiusY);

      final shader = RadialGradient(
        colors: [blob.color, Colors.transparent],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      paint.shader = shader;
      canvas.drawCircle(center, radius, paint);
    }

    // Reset shader for drawing particles
    paint.shader = null;

    // 2. Draw subtle grid of dots (standard tech/linear UI grid)
    final gridColor = isDark 
        ? Colors.white.withValues(alpha: 0.015) 
        : Colors.black.withValues(alpha: 0.015);
    paint.color = gridColor;
    double gridSpacing = 40.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      for (double y = 0; y < size.height; y += gridSpacing) {
        canvas.drawCircle(Offset(x, y), 0.75, paint);
      }
    }

    // 3. Draw particles
    final particleColor = isDark ? Colors.white : Colors.black;
    for (var p in particles) {
      final pos = Offset(p.x * size.width, p.y * size.height);
      paint.color = particleColor.withValues(alpha: p.opacity);
      canvas.drawCircle(pos, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) {
    return true; // We always redraw for active animation
  }
}
