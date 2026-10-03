import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/section_heading.dart';

class _AiCapability {
  const _AiCapability({required this.label, required this.description});

  final String label;
  final String description;
}

/// Section explaining how AI powers the MentorOS platform.
class AiSection extends StatefulWidget {
  const AiSection({super.key});

  @override
  State<AiSection> createState() => _AiSectionState();
}

class _AiSectionState extends State<AiSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  static const _capabilities = [
    _AiCapability(
      label: 'Goal Interpretation',
      description: 'Understands the intent behind your words, not just keywords.',
    ),
    _AiCapability(
      label: 'Skill Extraction',
      description:
          'Breaks goals down into the specific skills required to achieve them.',
    ),
    _AiCapability(
      label: 'Milestone Generation',
      description: 'Creates realistic, ordered steps from where you are to where you want to be.',
    ),
    _AiCapability(
      label: 'Mentor Matching',
      description: 'Identifies mentors whose experience maps to your exact journey.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < CosmicBreakpoints.mobile;
    final isDesktop = screenWidth > CosmicBreakpoints.tablet;

    final hPad = isMobile
        ? CosmicSpacing.sectionPaddingHMobile
        : isDesktop
            ? CosmicSpacing.sectionPaddingHDesktop
            : CosmicSpacing.sectionPaddingHTablet;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [CosmicColors.midnightNavy, CosmicColors.deepSpace],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile
            ? CosmicSpacing.sectionPaddingVMobile
            : CosmicSpacing.sectionPaddingV,
      ),
      child: isDesktop
          ? _buildDesktopLayout(screenWidth)
          : _buildMobileLayout(screenWidth),
    );
  }

  Widget _buildTextContent(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          label: 'INTELLIGENCE',
          title: 'AI that understands your journey',
          crossAxisAlignment: CrossAxisAlignment.start,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 24),
        Text(
          'MentorOS uses AI to interpret what you are trying to achieve, '
          'extract the skills required, identify where you currently are, '
          'and generate a meaningful mentorship path — not a generic one.',
          style: CosmicTextStyles.body(),
        ),
        const SizedBox(height: 40),
        ..._capabilities.map((c) => _CapabilityItem(capability: c)),
      ],
    );
  }

  Widget _buildNodeGraph() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, _) {
        return CustomPaint(
          painter: _AiNodePainter(
            animationValue: _pulseController.value,
          ),
          size: const Size(320, 320),
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
        const SizedBox(width: 64),
        Expanded(
          flex: 45,
          child: Center(child: _buildNodeGraph()),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double screenWidth) {
    return Column(
      children: [
        _buildTextContent(screenWidth),
        const SizedBox(height: 48),
        Center(child: _buildNodeGraph()),
      ],
    );
  }
}

class _CapabilityItem extends StatelessWidget {
  const _CapabilityItem({required this.capability});

  final _AiCapability capability;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: CosmicColors.cyberCyan,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capability.label,
                  style: CosmicTextStyles.subheading().copyWith(
                    fontSize: 16,
                    color: CosmicColors.starWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  capability.description,
                  style: CosmicTextStyles.bodySmall(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the AI node-graph visualization.
class _AiNodePainter extends CustomPainter {
  _AiNodePainter({required this.animationValue});

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const orbitRadius = 110.0;
    const centralRadius = 32.0;
    final satelliteRadius = 22.0;

    // Lines from center to satellites
    for (int i = 0; i < 4; i++) {
      final angle = (i / 4) * math.pi * 2 - math.pi / 4;
      final end = Offset(
        center.dx + orbitRadius * math.cos(angle),
        center.dy + orbitRadius * math.sin(angle),
      );
      final linePaint = Paint()
        ..color = CosmicColors.softLavender.withValues(alpha: 0.25)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawLine(center, end, linePaint);
    }

    // Central node glow
    final pulseRadius =
        centralRadius + 6 * animationValue;
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          CosmicColors.cosmicViolet.withValues(alpha: 0.4),
          CosmicColors.cosmicViolet.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: pulseRadius * 2),
      );
    canvas.drawCircle(center, pulseRadius * 2, glowPaint);

    // Central node
    final centralPaint = Paint()
      ..color = CosmicColors.cardSurface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, centralRadius, centralPaint);

    final centralBorderPaint = Paint()
      ..color = CosmicColors.cosmicViolet.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, centralRadius, centralBorderPaint);

    // Satellite nodes
    for (int i = 0; i < 4; i++) {
      final angle = (i / 4) * math.pi * 2 - math.pi / 4;
      final nodeCenter = Offset(
        center.dx + orbitRadius * math.cos(angle),
        center.dy + orbitRadius * math.sin(angle),
      );

      final satPaint = Paint()
        ..color = CosmicColors.cardSurface
        ..style = PaintingStyle.fill;
      canvas.drawCircle(nodeCenter, satelliteRadius, satPaint);

      final satBorder = Paint()
        ..color = CosmicColors.cyberCyan.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(nodeCenter, satelliteRadius, satBorder);

      // Small dot inside satellite
      final dotPaint = Paint()
        ..color = CosmicColors.cyberCyan.withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(nodeCenter, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_AiNodePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
