import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A single star particle used by [CosmicBackgroundPainter].
class _StarParticle {
  _StarParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
    required this.speed,
  });

  double x; // 0..1 fractional position
  double y; // 0..1 fractional position
  final double radius;
  final double opacity;
  final double speed; // relative drift speed
}

/// Paints a deep-space gradient plus animated star particles.
class _CosmicBackgroundPainter extends CustomPainter {
  _CosmicBackgroundPainter({
    required this.particles,
    required this.animationValue,
    required this.topColor,
    required this.bottomColor,
    this.showStars = true,
  });

  final List<_StarParticle> particles;
  final double animationValue; // 0..1
  final Color topColor;
  final Color bottomColor;
  final bool showStars;

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [topColor, bottomColor],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    if (!showStars) return;

    // Draw star particles
    for (final p in particles) {
      // Slow upward drift: y decreases over time, wraps at 0
      final driftedY = ((p.y - animationValue * p.speed * 0.15) % 1.0 + 1.0) % 1.0;

      // Subtle twinkle: oscillate opacity
      final twinkle = 0.4 + 0.6 * math.sin(animationValue * math.pi * 2 + p.x * 10);
      final effectiveOpacity = p.opacity * twinkle;

      final px = p.x * size.width;
      final py = driftedY * size.height;

      final paint = Paint()
        ..color = Color.lerp(
              Colors.white,
              CosmicColors.softLavender,
              p.x,
            )!
            .withValues(alpha: effectiveOpacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(px, py), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_CosmicBackgroundPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}

/// Animated cosmic background widget with star field and gradient.
///
/// Wrap any section in this widget to give it a deep-space atmosphere.
/// The animation is driven internally; the widget self-manages its
/// [AnimationController] lifecycle.
class CosmicBackground extends StatefulWidget {
  const CosmicBackground({
    super.key,
    this.child,
    this.topColor = CosmicColors.deepSpace,
    this.bottomColor = CosmicColors.midnightNavy,
    this.showStars = true,
    this.particleCount = 60,
  });

  final Widget? child;
  final Color topColor;
  final Color bottomColor;
  final bool showStars;
  final int particleCount;

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_StarParticle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _particles = _generateParticles(widget.particleCount);
  }

  List<_StarParticle> _generateParticles(int count) {
    final rng = math.Random(42); // deterministic seed for reproducibility
    return List.generate(count, (_) {
      return _StarParticle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        radius: 0.5 + rng.nextDouble() * 1.5,
        opacity: 0.2 + rng.nextDouble() * 0.6,
        speed: 0.3 + rng.nextDouble() * 0.7,
      );
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
        // Repaint only the background layer
        Positioned.fill(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _CosmicBackgroundPainter(
                    particles: _particles,
                    animationValue: _controller.value,
                    topColor: widget.topColor,
                    bottomColor: widget.bottomColor,
                    showStars: widget.showStars,
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}
