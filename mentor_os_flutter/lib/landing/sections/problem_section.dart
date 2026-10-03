import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/section_heading.dart';

class _Problem {
  const _Problem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// Section describing the problems MentorOS solves.
class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

  static const _problems = [
    _Problem(
      icon: Icons.help_outline,
      title: 'Vague Goals',
      description:
          'Most people do not know how to articulate what they want to achieve. Without clarity, mentorship has nowhere to go.',
    ),
    _Problem(
      icon: Icons.search_off,
      title: 'Wrong Mentors',
      description:
          'Finding a mentor who genuinely matches your goals is nearly impossible. Most platforms offer directories, not alignment.',
    ),
    _Problem(
      icon: Icons.shuffle,
      title: 'Unstructured Sessions',
      description:
          'Without a framework, mentorship drifts with no measurable outcomes. Each session starts from scratch.',
    ),
    _Problem(
      icon: Icons.trending_down,
      title: 'No Progress Tracking',
      description:
          'It is impossible to know if you are actually growing. Effort without measurement leads to frustration.',
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
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            CosmicColors.problemSectionMid,
            CosmicColors.deepSpace,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile
            ? CosmicSpacing.sectionPaddingVMobile
            : CosmicSpacing.sectionPaddingV,
      ),
      child: Column(
        children: [
          SectionHeading(
            label: 'THE CHALLENGE',
            title: 'Mentorship is broken.\nWe are fixing it.',
            subtitle:
                'The old way of finding mentors leaves too much to chance.',
          ),
          const SizedBox(height: 64),
          _buildGrid(screenWidth, isMobile),
        ],
      ),
    );
  }

  Widget _buildGrid(double screenWidth, bool isMobile) {
    if (isMobile) {
      return Column(
        children: _problems.map((p) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _ProblemCard(problem: p),
          );
        }).toList(),
      );
    }

    // 2-column grid for tablet and desktop
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _ProblemCard(problem: _problems[0]),
              const SizedBox(height: 20),
              _ProblemCard(problem: _problems[2]),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              _ProblemCard(problem: _problems[1]),
              const SizedBox(height: 20),
              _ProblemCard(problem: _problems[3]),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProblemCard extends StatelessWidget {
  const _ProblemCard({required this.problem});

  final _Problem problem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CosmicColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: CosmicColors.cosmicViolet,
            width: 3,
          ),
          top: BorderSide(color: CosmicColors.cardBorder),
          right: BorderSide(color: CosmicColors.cardBorder),
          bottom: BorderSide(color: CosmicColors.cardBorder),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CosmicColors.cosmicViolet.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              problem.icon,
              color: CosmicColors.softLavender,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  problem.title,
                  style: CosmicTextStyles.subheading().copyWith(fontSize: 17),
                ),
                const SizedBox(height: 8),
                Text(
                  problem.description,
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
