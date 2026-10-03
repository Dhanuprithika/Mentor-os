import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glow_button.dart';

/// Final CTA section with cosmic background.
class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < CosmicBreakpoints.mobile;

    final hPad = isMobile
        ? CosmicSpacing.sectionPaddingHMobile
        : CosmicSpacing.sectionPaddingHDesktop;

    return CosmicBackground(
      topColor: CosmicColors.ctaTopGradient,
      bottomColor: CosmicColors.deepSpace,
      particleCount: 40,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: hPad,
          vertical: isMobile
              ? CosmicSpacing.sectionPaddingVMobile
              : CosmicSpacing.sectionPaddingV,
        ),
        child: Column(
          children: [
            Text(
              'BEGIN YOUR JOURNEY',
              textAlign: TextAlign.center,
              style: CosmicTextStyles.label(),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                'Your journey starts with one goal.',
                textAlign: TextAlign.center,
                style: CosmicTextStyles.sectionHeading(screenWidth).copyWith(
                  fontSize: isMobile ? 32 : 52,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                'Define it. Let AI map it. Find your mentor.',
                textAlign: TextAlign.center,
                style: CosmicTextStyles.body().copyWith(
                  fontSize: 18,
                  color: CosmicColors.mutedText,
                ),
              ),
            ),
            const SizedBox(height: 48),
            GlowButton(
              label: 'Begin Your Journey',
              onPressed: () {},
              minWidth: 220,
            ),
          ],
        ),
      ),
    );
  }
}
