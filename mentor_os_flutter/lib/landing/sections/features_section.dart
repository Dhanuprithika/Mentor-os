import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/feature_card.dart';
import '../widgets/section_heading.dart';

class _Feature {
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// Section showcasing the 6 core features in a responsive grid.
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = [
    _Feature(
      icon: Icons.psychology,
      title: 'AI Goal Analysis',
      description: 'Deep understanding of your goals, not just keywords.',
    ),
    _Feature(
      icon: Icons.find_in_page,
      title: 'Skill Gap Detection',
      description: 'Automatically identifies what you need to learn.',
    ),
    _Feature(
      icon: Icons.hub,
      title: 'Smart Mentor Matching',
      description: 'Matches based on goals, not just job titles.',
    ),
    _Feature(
      icon: Icons.flag,
      title: 'Milestone Planning',
      description: 'Breaks your journey into clear, achievable steps.',
    ),
    _Feature(
      icon: Icons.handshake,
      title: 'Structured Mentorship',
      description: 'Every session has context, purpose, and direction.',
    ),
    _Feature(
      icon: Icons.show_chart,
      title: 'Progress Monitoring',
      description: 'Track your growth across your entire journey.',
    ),
  ];

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
            label: 'CAPABILITIES',
            title: 'Everything you need\nto grow with purpose.',
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              int columns;
              if (maxWidth > CosmicBreakpoints.tablet) {
                columns = 3;
              } else if (maxWidth > CosmicBreakpoints.mobile) {
                columns = 2;
              } else {
                columns = 1;
              }
              const spacing = 24.0;
              final cardWidth =
                  (maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: _features.map((f) {
                  return SizedBox(
                    width: cardWidth,
                    child: FeatureCard(
                      icon: f.icon,
                      title: f.title,
                      description: f.description,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
