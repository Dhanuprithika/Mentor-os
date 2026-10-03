import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glow_button.dart';

/// Hero section — full-viewport-height introduction to MentorOS.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, this.onSeHowItWorks});

  final VoidCallback? onSeHowItWorks;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _orbitController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    ));

    // Delay entry animation slightly
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final isDesktop = screenWidth > CosmicBreakpoints.tablet;
    final isMobile = screenWidth < CosmicBreakpoints.mobile;

    final hPad = isMobile
        ? CosmicSpacing.sectionPaddingHMobile
        : isDesktop
            ? CosmicSpacing.sectionPaddingHDesktop
            : CosmicSpacing.sectionPaddingHTablet;

    return CosmicBackground(
      topColor: CosmicColors.deepSpace,
      bottomColor: CosmicColors.midnightNavy,
      child: Container(
        constraints: BoxConstraints(minHeight: size.height),
        padding: EdgeInsets.fromLTRB(hPad, 64 + 48, hPad, 64),
        child: isDesktop
            ? _buildDesktopLayout(screenWidth)
            : _buildMobileLayout(screenWidth, isMobile),
      ),
    );
  }

  Widget _buildTextContent(double screenWidth) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tag label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: CosmicColors.cyberCyan.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(20),
                color: CosmicColors.cyberCyan.withValues(alpha: 0.08),
              ),
              child: Text(
                'AI-POWERED MENTORSHIP',
                style: CosmicTextStyles.label(),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Turn Your Goals\nInto A Path Forward.',
              style: CosmicTextStyles.heroHeading(screenWidth),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                'MentorOS uses AI to understand your goals, identify skill gaps, '
                'structure milestones, and connect you with the right mentor.',
                style: CosmicTextStyles.body(),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GlowButton(
                  label: 'Start Your Journey',
                  onPressed: () {},
                ),
                GlowButton(
                  label: 'See How It Works',
                  onPressed: widget.onSeHowItWorks ?? () {},
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCosmicVisual() {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, _) {
        return CustomPaint(
          painter: _CosmicRingsPainter(
            animationValue: _orbitController.value,
          ),
          size: const Size(340, 340),
        );
      },
    );
  }

  Widget _buildDesktopLayout(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 55,
          child: _buildTextContent(screenWidth),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 45,
          child: Center(child: _buildCosmicVisual()),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double screenWidth, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTextContent(screenWidth),
        const SizedBox(height: 48),
        Center(
          child: SizedBox(
            width: isMobile ? 240 : 300,
            height: isMobile ? 240 : 300,
            child: _buildCosmicVisual(),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the cosmic rings / AI core visual in the hero.
class _CosmicRingsPainter extends CustomPainter {
  _CosmicRingsPainter({required this.animationValue});

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 0.45;

    // Outer rings (rotating dashed)
    for (int r = 3; r >= 1; r--) {
      final radius = maxRadius * (r / 3.0);
      final ringPaint = Paint()
        ..color = CosmicColors.softLavender
            .withValues(alpha: 0.06 + r * 0.04)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(center, radius, ringPaint);
    }

    // Rotating accent arc
    final arcPaint = Paint()
      ..color = CosmicColors.cyberCyan.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animationValue * math.pi * 2);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: maxRadius),
      0,
      math.pi * 0.6,
      false,
      arcPaint,
    );
    canvas.restore();

    // Counter-rotating accent arc
    final arcPaint2 = Paint()
      ..color = CosmicColors.softLavender.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-animationValue * math.pi * 2 * 0.7);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: maxRadius * 0.7),
      math.pi * 0.2,
      math.pi * 0.5,
      false,
      arcPaint2,
    );
    canvas.restore();

    // Orbital dots
    for (int i = 0; i < 4; i++) {
      final angle = animationValue * math.pi * 2 + (i * math.pi / 2);
      final dotX = center.dx + maxRadius * math.cos(angle);
      final dotY = center.dy + maxRadius * math.sin(angle);
      final dotPaint = Paint()
        ..color = CosmicColors.cyberCyan.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(dotX, dotY), 3.0, dotPaint);
    }

    // Inner glow
    final innerGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          CosmicColors.cosmicViolet.withValues(alpha: 0.6),
          CosmicColors.cosmicViolet.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: maxRadius * 0.35),
      );
    canvas.drawCircle(center, maxRadius * 0.35, innerGlowPaint);

    // Core circle
    final corePaint = Paint()
      ..color = CosmicColors.cardSurface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 36, corePaint);

    final coreBorderPaint = Paint()
      ..color = CosmicColors.softLavender.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, 36, coreBorderPaint);

    // "AI" text represented as dots (since canvas text needs TextPainter)
    final dotCenter = Paint()
      ..color = CosmicColors.cyberCyan.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5, dotCenter);

    // Pulse ring on core
    final pulseRadius = 36 + 8 * math.sin(animationValue * math.pi * 2);
    final pulsePaint = Paint()
      ..color = CosmicColors.softLavender.withValues(
          alpha: 0.3 * (1 - math.sin(animationValue * math.pi).abs()))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, pulseRadius, pulsePaint);
  }

  @override
  bool shouldRepaint(_CosmicRingsPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
