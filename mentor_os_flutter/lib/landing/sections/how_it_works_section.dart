import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/section_heading.dart';

class _Step {
  const _Step({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
  final String title;
  final String description;
}

/// Section showing the 4-step "How It Works" flow.
class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = [
    _Step(
      number: '01',
      title: 'Define your goal',
      description: 'Tell MentorOS what you want to achieve in your own words.',
    ),
    _Step(
      number: '02',
      title: 'AI understands it',
      description:
          'Our AI interprets your goal, extracts skills needed, and identifies gaps.',
    ),
    _Step(
      number: '03',
      title: 'Match with a mentor',
      description:
          'Get matched with mentors based on your specific goals and gaps.',
    ),
    _Step(
      number: '04',
      title: 'Build your growth path',
      description:
          'Receive a structured milestone plan tailored to your journey.',
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
      color: CosmicColors.deepSpace,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile
            ? CosmicSpacing.sectionPaddingVMobile
            : CosmicSpacing.sectionPaddingV,
      ),
      child: Column(
        children: [
          SectionHeading(
            label: 'HOW IT WORKS',
            title: 'Simple by design.\nPowerful by default.',
          ),
          const SizedBox(height: 72),
          isMobile
              ? _buildMobileSteps()
              : _buildDesktopSteps(screenWidth),
        ],
      ),
    );
  }

  Widget _buildDesktopSteps(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector line
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Container(
                height: 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CosmicColors.cosmicViolet.withValues(alpha: 0.4),
                      CosmicColors.cyberCyan.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        final step = _steps[i ~/ 2];
        return Expanded(
          flex: 3,
          child: _StepCard(step: step),
        );
      }),
    );
  }

  Widget _buildMobileSteps() {
    return Column(
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Container(
            width: 1.5,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CosmicColors.cosmicViolet.withValues(alpha: 0.5),
                  CosmicColors.cyberCyan.withValues(alpha: 0.5),
                ],
              ),
            ),
          );
        }
        return _StepCard(step: _steps[i ~/ 2], isMobile: true);
      }),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step, this.isMobile = false});

  final _Step step;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 16),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            step.number,
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
            style: CosmicTextStyles.stepNumber(),
          ),
          const SizedBox(height: 12),
          Text(
            step.title,
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
            style: CosmicTextStyles.subheading().copyWith(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            step.description,
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
            style: CosmicTextStyles.bodySmall(),
          ),
        ],
      ),
    );
  }
}
