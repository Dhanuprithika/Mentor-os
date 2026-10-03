import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/section_heading.dart';

/// Data model for a single journey node.
class _JourneyNode {
  const _JourneyNode({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// Section showing the Goal → AI → Mentor constellation path.
class JourneySection extends StatefulWidget {
  const JourneySection({super.key});

  @override
  State<JourneySection> createState() => _JourneySectionState();
}

class _JourneySectionState extends State<JourneySection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _nodeAnimations;

  static const _nodes = [
    _JourneyNode(
      icon: Icons.flag_outlined,
      title: 'Define Your Goal',
      description: 'Tell us what you want to achieve',
    ),
    _JourneyNode(
      icon: Icons.psychology_outlined,
      title: 'AI Goal Analysis',
      description: 'AI interprets your goals and extracts required skills',
    ),
    _JourneyNode(
      icon: Icons.school_outlined,
      title: 'Skill Gaps & Milestones',
      description: 'Identify gaps and break the journey into steps',
    ),
    _JourneyNode(
      icon: Icons.people_outlined,
      title: 'Mentor Matching',
      description: 'Get matched with mentors aligned to your goals',
    ),
    _JourneyNode(
      icon: Icons.trending_up,
      title: 'Structured Growth',
      description: 'Build, track, and measure real progress',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _nodeAnimations = List.generate(_nodes.length, (i) {
      final start = i / (_nodes.length + 1);
      final end = (i + 1) / (_nodes.length + 1);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
      color: CosmicColors.midnightNavy,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile
            ? CosmicSpacing.sectionPaddingVMobile
            : CosmicSpacing.sectionPaddingV,
      ),
      child: Column(
        children: [
          SectionHeading(
            label: 'THE JOURNEY',
            title: 'Your journey, structured by AI',
            subtitle:
                'From a vague aspiration to a clear, mentor-supported growth path.',
          ),
          const SizedBox(height: 72),
          _buildPath(isMobile),
        ],
      ),
    );
  }

  Widget _buildPath(bool isMobile) {
    return Column(
      children: List.generate(_nodes.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector
          return _buildConnector(isMobile);
        }
        final nodeIndex = i ~/ 2;
        final isRight = nodeIndex.isOdd;
        return FadeTransition(
          opacity: _nodeAnimations[nodeIndex],
          child: _buildNodeCard(
            _nodes[nodeIndex],
            nodeIndex,
            isRight: isRight && !isMobile,
          ),
        );
      }),
    );
  }

  Widget _buildConnector(bool isMobile) {
    return Center(
      child: Container(
        width: 1.5,
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CosmicColors.softLavender.withValues(alpha: 0.5),
              CosmicColors.cyberCyan.withValues(alpha: 0.5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNodeCard(
    _JourneyNode node,
    int index, {
    bool isRight = false,
  }) {
    final offsetX = isRight ? 60.0 : -60.0;

    final card = Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CosmicColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CosmicColors.cardBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: CosmicColors.cyberCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              node.icon,
              color: CosmicColors.cyberCyan,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  node.title,
                  style: CosmicTextStyles.subheading().copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  node.description,
                  style: CosmicTextStyles.bodySmall().copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (isRight) {
      return Transform.translate(
        offset: Offset(offsetX, 0),
        child: Align(alignment: Alignment.center, child: card),
      );
    }
    return Transform.translate(
      offset: Offset(offsetX, 0),
      child: Align(alignment: Alignment.center, child: card),
    );
  }
}
